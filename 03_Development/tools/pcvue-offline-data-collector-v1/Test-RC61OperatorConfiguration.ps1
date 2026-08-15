#requires -version 5.1
[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)][string]$PackageRoot,
    [Parameter(Mandatory=$true)][string]$FixturePath
)

$ErrorActionPreference='Stop'
$results=@()
function Add-TestResult { param($Name,$Passed,$Detail) $script:results += [pscustomobject]@{Name=$Name;Passed=[bool]$Passed;Detail=[string]$Detail} }
function Assert-True { param($Condition,$Message) if(-not $Condition){throw $Message} }
function Copy-Package { $d=Join-Path $env:TEMP ('PCVueRC61_'+[guid]::NewGuid().ToString('N'));Copy-Item -LiteralPath $PackageRoot -Destination $d -Recurse;return $d }
function Invoke-StaticValidation {
    param($Root)
    & 'C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe' -NoLogo -NoProfile -NonInteractive -ExecutionPolicy Bypass -File (Join-Path $Root 'Check-PCVueCollector.ps1') -PackageRoot $Root *> $null
    return $LASTEXITCODE
}

$temporary=@()
$externalTemporary=@()
try {
    $collectorPath=Join-Path $PackageRoot 'Collect-PCVueOfflineData.ps1'
    $tokens=$null;$errors=$null
    $ast=[Management.Automation.Language.Parser]::ParseFile($collectorPath,[ref]$tokens,[ref]$errors)
    Assert-True ($errors.Count -eq 0) ('Collector parse errors: '+(($errors|ForEach-Object {$_.Message}) -join '; '))
    foreach($name in @('Get-Sha256Text','Get-OperatorRootPolicyResult')){
        $fn=@($ast.FindAll({param($n) $n -is [Management.Automation.Language.FunctionDefinitionAst] -and $n.Name -eq $name},$true))[0]
        Assert-True ($null -ne $fn) ("Function missing: $name")
        Invoke-Expression $fn.Extent.Text
    }
    Add-TestResult 'PS51_PARSE' $true $PSVersionTable.PSVersion.ToString()

    $fixtureLine=@(Get-Content -LiteralPath $FixturePath -Encoding UTF8 | Where-Object {$_ -and -not $_.StartsWith('#')})[0]
    $fixtureResult=Get-OperatorRootPolicyResult $fixtureLine
    Assert-True $fixtureResult.Accepted ('D fixture rejected: '+$fixtureResult.Reason)
    Add-TestResult 'D_PROJECT_FILES_POLICY_FIXTURE' $true ($fixtureResult.Canonical+' '+$fixtureResult.Reason)

    foreach($case in @(
        @{Path='D:\';Reason='DRIVE_ROOT_PROHIBITED'},
        @{Path='\\server\share';Reason='UNC_OR_DEVICE_PATH'},
        @{Path='C:\Windows\Temp';Reason='SYSTEM_OR_USER_PROFILE_PATH'},
        @{Path='C:\Users\Operator\Project';Reason='SYSTEM_OR_USER_PROFILE_PATH'},
        @{Path='relative\project';Reason='NOT_ABSOLUTE_LOCAL_PATH'}
    )){
        $actual=Get-OperatorRootPolicyResult $case.Path
        Assert-True ((-not $actual.Accepted) -and $actual.Reason -eq $case.Reason) ("Unexpected policy result for $($case.Path): $($actual.Reason)")
    }
    Add-TestResult 'PROHIBITED_PATH_POLICY' $true 'drive root, UNC, Windows, Users and relative paths rejected'

    $copy=Copy-Package;$temporary+=$copy
    [IO.File]::WriteAllText((Join-Path $copy 'AdditionalProjectRoots.txt'),"D:\Project Files`r`n",[Text.UTF8Encoding]::new($true))
    Assert-True ((Invoke-StaticValidation $copy) -eq 0) 'Mutable operator configuration change blocked static validation.'
    Add-TestResult 'MUTABLE_CONFIG_STATIC_VALIDATION' $true 'content change did not weaken immutable validation'

    Add-Content -LiteralPath (Join-Path $copy 'Collect-PCVueOfflineData.ps1') -Value '# tamper'
    Assert-True ((Invoke-StaticValidation $copy) -ne 0) 'Executable tamper was not fail-closed.'
    Add-TestResult 'EXECUTABLE_TAMPER_FAIL_CLOSED' $true 'collector checksum mismatch rejected before execution'

    $copy=Copy-Package;$temporary+=$copy
    Add-Content -LiteralPath (Join-Path $copy 'PACKAGE_SHA256SUMS.txt') -Value ('0'*64+'  AdditionalProjectRoots.txt')
    Assert-True ((Invoke-StaticValidation $copy) -ne 0) 'Mutable configuration was accepted in immutable baseline.'
    Add-TestResult 'MUTABLE_BASELINE_SEPARATION' $true 'baseline entry rejected'

    $copy=Copy-Package;$temporary+=$copy
    $project=Join-Path 'C:\' ('PCVueRC61_Test_'+[guid]::NewGuid().ToString('N'));New-Item -ItemType Directory -Path $project | Out-Null;$externalTemporary+=$project
    [IO.File]::WriteAllText((Join-Path $project '.pcvue-project'),'fixture',[Text.UTF8Encoding]::new($true))
    [IO.File]::WriteAllText((Join-Path $copy 'AdditionalProjectRoots.txt'),($project+"`r`n"),[Text.UTF8Encoding]::new($true))
    $expectedConfigHash=(Get-FileHash -LiteralPath (Join-Path $copy 'AdditionalProjectRoots.txt') -Algorithm SHA256).Hash
    $out=Join-Path $copy 'TestOutput';New-Item -ItemType Directory -Path $out | Out-Null
    & 'C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe' -NoLogo -NoProfile -NonInteractive -ExecutionPolicy Bypass -File (Join-Path $copy 'Collect-PCVueOfflineData.ps1') -OutputRoot $out -ConfigPath (Join-Path $copy 'CollectorConfig.psd1') -SimulationRoot $project *> $null
    Assert-True ($LASTEXITCODE -in @(0,10)) ("Collector fixture exit code: $LASTEXITCODE")
    $run=@(Get-ChildItem -LiteralPath $out -Directory | Sort-Object LastWriteTime -Descending)[0]
    $audit=@(Import-Csv -LiteralPath (Join-Path $run.FullName 'OPERATOR_CONFIGURATION_AUDIT.csv') -Encoding UTF8)[0]
    Assert-True ($audit.SHA256 -eq $expectedConfigHash) 'Runtime operator configuration hash mismatch.'
    Assert-True ($audit.Classification -eq 'MUTABLE_OPERATOR_CONFIGURATION') 'Mutable classification missing.'
    $evidence=@(Import-Csv -LiteralPath (Join-Path $run.FullName '02_PCVue_Project\root_evidence.csv') -Encoding UTF8)
    Assert-True (@($evidence|Where-Object {$_.EvidenceCode -eq 'OPERATOR_APPROVED' -and $_.Result -like 'ACCEPTED:*'}).Count -gt 0) 'Accepted OPERATOR_APPROVED evidence missing.'
    $manifest=@(Import-Csv -LiteralPath (Join-Path $run.FullName 'COLLECTION_MANIFEST.csv') -Encoding UTF8)
    Assert-True ($manifest.RelativePath -contains 'OPERATOR_CONFIGURATION_AUDIT.csv') 'Audit file missing from manifest.'
    Add-TestResult 'RUNTIME_AUDIT_AND_EVIDENCE' $true 'configuration hash, manifest and OPERATOR_APPROVED evidence verified'
} catch {
    Add-TestResult 'UNHANDLED_FAILURE' $false $_.Exception.Message
} finally {
    foreach($path in $temporary){if(Test-Path -LiteralPath $path){Remove-Item -LiteralPath $path -Recurse -Force}}
    foreach($path in $externalTemporary){if(Test-Path -LiteralPath $path){Remove-Item -LiteralPath $path -Recurse -Force}}
}

$results | Format-Table -AutoSize
if(@($results|Where-Object {-not $_.Passed}).Count -gt 0){exit 1}
exit 0
