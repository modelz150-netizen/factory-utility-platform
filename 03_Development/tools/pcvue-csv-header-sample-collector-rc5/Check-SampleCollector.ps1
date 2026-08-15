#requires -version 5.1
[CmdletBinding()]
param([Parameter(Mandatory=$true)][AllowNull()][object]$PackageRoot)
$ErrorActionPreference='Stop'
$failed=$false
function Stop-InvalidPackageRoot([string]$Reason) {Write-Host ("[ERROR] Invalid PackageRoot: {0}" -f $Reason);Write-Host '[ERROR] Static validation stopped; collector was not executed.';exit 2}
if (-not $PSBoundParameters.ContainsKey('PackageRoot')) {Stop-InvalidPackageRoot 'argument not supplied'}
if ($PackageRoot -is [Array]) {Stop-InvalidPackageRoot 'exactly one path is required'}
if ($PackageRoot -isnot [string]) {Stop-InvalidPackageRoot 'a single string path is required'}
if ($args.Count -gt 0) {Stop-InvalidPackageRoot 'unexpected additional argument data'}
$rootText=[string]$PackageRoot
if ([string]::IsNullOrWhiteSpace($rootText)) {Stop-InvalidPackageRoot 'path is null or empty'}
if ($rootText.IndexOf([char]0)-ge 0 -or $rootText.IndexOf([char]13)-ge 0 -or $rootText.IndexOf([char]10)-ge 0) {Stop-InvalidPackageRoot 'prohibited control character'}
if ($rootText.IndexOf([char]34)-ge 0) {Stop-InvalidPackageRoot 'embedded quote indicates malformed quoting'}
try {$normalized=[IO.Path]::GetFullPath($rootText)} catch {Stop-InvalidPackageRoot 'illegal characters or normalization failure'}
try {
    if (-not (Test-Path -LiteralPath $normalized -PathType Container -ErrorAction Stop)) {Stop-InvalidPackageRoot 'directory does not exist'}
    $resolved=@(Resolve-Path -LiteralPath $normalized -ErrorAction Stop)
} catch {Stop-InvalidPackageRoot 'directory cannot be safely resolved'}
if ($resolved.Count -ne 1) {Stop-InvalidPackageRoot 'path did not resolve to exactly one directory'}
$root=$resolved[0].ProviderPath
$required=@('Collect-PCVueCsvHeaders.ps1','Check-SampleCollector.ps1','SampleConfig.psd1','RUN_SAMPLE_COLLECTOR.cmd','README_KO.txt','VERSION.txt')
foreach ($name in $required) {if (-not (Test-Path -LiteralPath (Join-Path $root $name) -PathType Leaf)) {Write-Host ("[ERROR] Missing: {0}" -f $name);$failed=$true}}
$forbidden=@('Invoke-WebRequest','Invoke-RestMethod','Invoke-Command','Enter-PSSession','New-PSSession','Stop-Service','Start-Service','Restart-Service','Set-Service','Set-ItemProperty','New-ItemProperty','Remove-ItemProperty','Start-Process','Copy-Item')
foreach ($name in @('Collect-PCVueCsvHeaders.ps1','Check-SampleCollector.ps1')) {
    $path=Join-Path $root $name
    $tokens=$null;$errors=$null
    $ast=[Management.Automation.Language.Parser]::ParseFile($path,[ref]$tokens,[ref]$errors)
    foreach ($e in @($errors)) {Write-Host ("[ERROR] Parse {0}:{1} {2}" -f $name,$e.Extent.StartLineNumber,$e.Message);$failed=$true}
    if ($name -ne 'Check-SampleCollector.ps1') {
        foreach ($cmd in @($ast.FindAll({param($n) $n -is [Management.Automation.Language.CommandAst]},$true))) {
            $command=$cmd.GetCommandName()
            if ($command -and $forbidden -contains $command) {Write-Host ("[ERROR] Forbidden: {0}" -f $command);$failed=$true}
            if ($command -and $command -match '(?i)\.(exe|cmd|bat|com)$') {Write-Host ("[ERROR] External executable: {0}" -f $command);$failed=$true}
        }
    }
}
$source=[IO.File]::ReadAllText((Join-Path $root 'Collect-PCVueCsvHeaders.ps1'))
$requiredInvariants=@(
 'FileMode]::Open','FileAccess]::Read','Read-LimitedDiscovery','MaxVarexpLogicalRecords','MaxDiscoveryBytes',
 'SCHEMA_RECORD_INDEX','LOGICAL_RECORDS_READ','BYTES_READ','STOP_REASON','STRUCTURE_STATUS',
 'HISTO_CONTENT_NOT_ACCESSED','MANUAL_FORMAT_REVIEW_REQUIRED','DATA_ROWS_STORED=0','RAW_NON_SCHEMA_ROWS_STORED=0',
 'CreateFromDirectory','SENSITIVE_REVIEW_REQUIRED'
)
foreach ($text in $requiredInvariants) {if ($source.IndexOf($text,[StringComparison]::Ordinal)-lt 0) {Write-Host ("[ERROR] Invariant missing: {0}" -f $text);$failed=$true}}
$apostrophe=[char]39
foreach ($pattern in @(('throw'+$apostrophe),('return'+$apostrophe),('Write-Host'+$apostrophe),('Write-Output'+$apostrophe))) {
    if ($source.IndexOf($pattern,[StringComparison]::OrdinalIgnoreCase)-ge 0) {Write-Host ("[ERROR] Tokenization-risk spacing: {0}" -f $pattern);$failed=$true}
}
foreach ($text in @('Get-Content -LiteralPath $file','Copy-Item','Invoke-WebRequest','Invoke-RestMethod','Start-Service','Stop-Service','Restart-Service')) {
    if ($source.IndexOf($text,[StringComparison]::OrdinalIgnoreCase)-ge 0) {Write-Host ("[ERROR] Prohibited pattern: {0}" -f $text);$failed=$true}
}
$config=Import-PowerShellDataFile -LiteralPath (Join-Path $root 'SampleConfig.psd1')
if ($config.Samples.Count -ne 11) {Write-Host '[ERROR] Exactly 11 samples required.';$failed=$true}
if ([int]$config.MaxVarexpLogicalRecords -ne 3) {Write-Host '[ERROR] VAREXP record boundary must be 3.';$failed=$true}
if ([int]$config.MaxPvTrendLogicalRecords -ne 1) {Write-Host '[ERROR] PvTrend record boundary must be 1.';$failed=$true}
if ([int]$config.MaxDiscoveryBytes -ne 65536) {Write-Host '[ERROR] Byte boundary must be 65536.';$failed=$true}
foreach ($s in $config.Samples) {
    if ($s.RelativePath -notmatch '(?i)\.csv$' -or [IO.Path]::IsPathRooted($s.RelativePath) -or $s.RelativePath.Contains('..')) {Write-Host ("[ERROR] Invalid sample: {0}" -f $s.RelativePath);$failed=$true}
    if (@('VAREXP','HISTO','PVTREND') -notcontains $s.Domain) {Write-Host '[ERROR] Invalid domain.';$failed=$true}
}
if (@($config.Samples | Where-Object Domain -eq 'VAREXP').Count -ne 5 -or @($config.Samples | Where-Object Domain -eq 'HISTO').Count -ne 5 -or @($config.Samples | Where-Object Domain -eq 'PVTREND').Count -ne 1) {Write-Host '[ERROR] Domain counts must be VAREXP 5, HISTO 5, PVTREND 1.';$failed=$true}
$baseline=Join-Path $root 'PACKAGE_SHA256SUMS.txt'
if (-not (Test-Path -LiteralPath $baseline -PathType Leaf)) {Write-Host '[ERROR] Baseline missing';$failed=$true} else {
    foreach ($line in Get-Content -LiteralPath $baseline -Encoding UTF8) {
        if ([string]::IsNullOrWhiteSpace($line)) {continue}
        if ($line -notmatch '^([A-Fa-f0-9]{64})\s{2}(.+)$') {Write-Host '[ERROR] Invalid baseline line';$failed=$true;continue}
        $target=Join-Path $root $matches[2]
        if (-not (Test-Path -LiteralPath $target -PathType Leaf) -or (Get-FileHash -LiteralPath $target -Algorithm SHA256).Hash -ne $matches[1]) {Write-Host ("[ERROR] Checksum mismatch: {0}" -f $matches[2]);$failed=$true}
    }
}
if ($failed) {exit 1}
Write-Host 'Static/security validation passed.'
exit 0
