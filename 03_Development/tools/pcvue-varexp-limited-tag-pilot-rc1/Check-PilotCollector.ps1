#requires -version 5.1
[CmdletBinding()]param([Parameter(Mandatory=$true)][AllowNull()][object]$PackageRoot)
$ErrorActionPreference='Stop';$failed=$false
function Fail-Root([string]$Reason){Write-Host("[ERROR] Invalid PackageRoot: {0}"-f$Reason);exit 2}
if($PackageRoot-is[Array]-or$PackageRoot-isnot[string]){Fail-Root 'single string required'}
$r=[string]$PackageRoot;if([string]::IsNullOrWhiteSpace($r)-or$r.IndexOf([char]0)-ge0-or$r.IndexOf([char]10)-ge0-or$r.IndexOf([char]13)-ge0-or$r.IndexOf([char]34)-ge0){Fail-Root 'malformed'}
try{$root=[IO.Path]::GetFullPath($r)}catch{Fail-Root 'normalization'}
if(-not(Test-Path -LiteralPath $root -PathType Container)){Fail-Root 'missing'}
$required=@('Collect-LimitedVarexpTags.ps1','Check-PilotCollector.ps1','PilotConfig.psd1','RUN_LIMITED_PILOT.cmd','README_KO.txt','VERSION.txt')
foreach($n in $required){if(-not(Test-Path -LiteralPath(Join-Path $root $n)-PathType Leaf)){Write-Host("[ERROR] Missing: {0}"-f$n);$failed=$true}}
$forbidden=@('Invoke-WebRequest','Invoke-RestMethod','Invoke-Command','Enter-PSSession','New-PSSession','Start-Service','Stop-Service','Restart-Service','Set-Service','Start-Process','Copy-Item','Remove-Item','Move-Item')
foreach($n in @('Collect-LimitedVarexpTags.ps1','Check-PilotCollector.ps1')){
 $tokens=$null;$errors=$null;$ast=[Management.Automation.Language.Parser]::ParseFile((Join-Path $root $n),[ref]$tokens,[ref]$errors)
 foreach($e in @($errors)){Write-Host("[ERROR] Parse {0}:{1} {2}"-f$n,$e.Extent.StartLineNumber,$e.Message);$failed=$true}
 if($n-ne'Check-PilotCollector.ps1'){foreach($cmd in @($ast.FindAll({param($x)$x-is[Management.Automation.Language.CommandAst]},$true))){$c=$cmd.GetCommandName();if($c-and$forbidden-contains$c){Write-Host("[ERROR] Forbidden: {0}"-f$c);$failed=$true};if($c-and$c-match'(?i)\.(exe|cmd|bat|com)$'){Write-Host("[ERROR] External: {0}"-f$c);$failed=$true}}}
}
$source=[IO.File]::ReadAllText((Join-Path $root 'Collect-LimitedVarexpTags.ps1'))
foreach($x in @('FileMode]::Open','FileAccess]::Read','MaxDataRecordsPerFile','MaxDataBytesPerFile','MaxTotalEmitRows','FIELD_COUNT_','VAREXP_COL_{0:D3}','RAW_ROWS_STORED=0','EXCLUDED_FIELD_VALUES_STORED=0','CREDENTIAL_SECRET_RAW_VALUES_STORED=0','CreateFromDirectory')){if($source.IndexOf($x,[StringComparison]::Ordinal)-lt0){Write-Host("[ERROR] Missing invariant: {0}"-f$x);$failed=$true}}
foreach($x in @('Get-Content -LiteralPath $file','Copy-Item','Invoke-WebRequest','Invoke-RestMethod','Start-Service','Stop-Service')){if($source.IndexOf($x,[StringComparison]::OrdinalIgnoreCase)-ge0){Write-Host("[ERROR] Prohibited source: {0}"-f$x);$failed=$true}}
$config=Import-PowerShellDataFile -LiteralPath(Join-Path $root 'PilotConfig.psd1')
$expected=@(1,2,16,17,18,19,20,21,22,47,48,51,52,66,73,163,166)
if($config.Sources.Count-ne5){Write-Host '[ERROR] Five sources required';$failed=$true}
if([int]$config.MaxDataRecordsPerFile-ne20-or[int]$config.MaxDataBytesPerFile-ne262144-or[int]$config.MaxTotalEmitRows-ne100){Write-Host '[ERROR] Boundary mismatch';$failed=$true}
if(($config.AllowPositions-join',')-ne($expected-join',')){Write-Host '[ERROR] Allowlist mismatch';$failed=$true}
foreach($s in $config.Sources){if($s.RelativePath-notmatch'(?i)\.csv$'-or[IO.Path]::IsPathRooted($s.RelativePath)-or$s.RelativePath.Contains('..')-or$s.SourceFileId-notmatch'^VAREXP_0[1-5]$'){Write-Host '[ERROR] Invalid source';$failed=$true}}
$base=Join-Path $root 'PACKAGE_SHA256SUMS.txt'
if(-not(Test-Path -LiteralPath $base -PathType Leaf)){Write-Host '[ERROR] Baseline missing';$failed=$true}else{foreach($line in Get-Content -LiteralPath $base -Encoding UTF8){if([string]::IsNullOrWhiteSpace($line)){continue};if($line-notmatch'^([A-Fa-f0-9]{64})\s{2}(.+)$'){Write-Host '[ERROR] Baseline format';$failed=$true;continue};$target=Join-Path $root $matches[2];if(-not(Test-Path -LiteralPath $target -PathType Leaf)-or(Get-FileHash -LiteralPath $target -Algorithm SHA256).Hash-ne$matches[1]){Write-Host("[ERROR] Checksum: {0}"-f$matches[2]);$failed=$true}}}
if($failed){exit 1};Write-Host 'Static/security validation passed.';exit 0
