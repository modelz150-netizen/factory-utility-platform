#requires -version 5.1
[CmdletBinding()]
param(
 [AllowNull()][object]$ProjectRoot='D:\Project Files',
 [AllowNull()][object]$OutputRoot,
 [AllowNull()][object]$ConfigPath
)
$ErrorActionPreference='Stop'
Set-StrictMode -Version 2.0

function Stop-PathFailure([string]$Name,[string]$Reason) {
    Write-Host ("[ERROR] Invalid {0}: {1}" -f $Name,$Reason)
    Write-Host '[ERROR] Collector stopped before content access.'
    exit 2
}
function Get-SinglePathText([object]$Value,[string]$Name,[bool]$AllowMissing) {
    if ($Value -is [Array]) { Stop-PathFailure $Name 'exactly one path is required' }
    if ($null -eq $Value) { if ($AllowMissing) { return $null }; Stop-PathFailure $Name 'path is null' }
    if ($Value -isnot [string]) { Stop-PathFailure $Name 'a single string path is required' }
    $text=[string]$Value
    if ([string]::IsNullOrWhiteSpace($text)) { if ($AllowMissing) { return $null }; Stop-PathFailure $Name 'path is empty' }
    if ($text.IndexOf([char]0)-ge 0 -or $text.IndexOf([char]13)-ge 0 -or $text.IndexOf([char]10)-ge 0) { Stop-PathFailure $Name 'prohibited control character' }
    if ($text.IndexOf([char]34)-ge 0) { Stop-PathFailure $Name 'embedded quote' }
    try { return [IO.Path]::GetFullPath($text) } catch { Stop-PathFailure $Name 'illegal characters or normalization failure' }
}
$scriptRootText=Get-SinglePathText $PSScriptRoot 'PSScriptRoot' $false
if (-not (Test-Path -LiteralPath $scriptRootText -PathType Container)) { Stop-PathFailure 'PSScriptRoot' 'directory not found' }
$projectRootText=Get-SinglePathText $ProjectRoot 'ProjectRoot' $false
$outputRootText=Get-SinglePathText $OutputRoot 'OutputRoot' $true
$configPathText=Get-SinglePathText $ConfigPath 'ConfigPath' $true
if ($null -eq $outputRootText) { $outputRootText=[IO.Path]::GetFullPath((Join-Path $scriptRootText 'Sample_Output')) }
if ($null -eq $configPathText) { $configPathText=[IO.Path]::GetFullPath((Join-Path $scriptRootText 'SampleConfig.psd1')) }
if (-not (Test-Path -LiteralPath $configPathText -PathType Leaf)) { Stop-PathFailure 'ConfigPath' 'file not found' }
$ProjectRoot=$projectRootText
$OutputRoot=$outputRootText
$ConfigPath=$configPathText

function Get-Sha256([string]$Path) { (Get-FileHash -LiteralPath $Path -Algorithm SHA256).Hash.ToUpperInvariant() }
function Test-Reparse([string]$Path) { ((Get-Item -LiteralPath $Path -Force).Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0 }
function Get-ApprovedRoot([string]$Path) {
    if ([string]::IsNullOrWhiteSpace($Path) -or $Path.StartsWith('\\') -or $Path.StartsWith('\\?\') -or $Path.StartsWith('\\.\')) { throw 'UNC_OR_DEVICE_PATH' }
    if (-not [IO.Path]::IsPathRooted($Path)) { throw 'ROOT_NOT_ABSOLUTE' }
    $full=[IO.Path]::GetFullPath($Path).TrimEnd('\')
    if (-not (Test-Path -LiteralPath $full -PathType Container)) { throw 'ROOT_NOT_FOUND' }
    if (Test-Reparse $full) { throw 'ROOT_REPARSE_POINT' }
    $drive=New-Object IO.DriveInfo([IO.Path]::GetPathRoot($full))
    if ($drive.DriveType -ne [IO.DriveType]::Fixed) { throw ('ROOT_NOT_FIXED_DRIVE:{0}' -f $drive.DriveType) }
    return $full
}
function Get-SafeSamplePath([string]$Root,[string]$RelativePath) {
    if ([IO.Path]::IsPathRooted($RelativePath) -or $RelativePath.Contains('..') -or $RelativePath -notmatch '(?i)\.csv$') { throw 'INVALID_RELATIVE_PATH' }
    $candidate=[IO.Path]::GetFullPath((Join-Path $Root $RelativePath))
    $prefix=$Root.TrimEnd('\')+'\'
    if (-not $candidate.StartsWith($prefix,[StringComparison]::OrdinalIgnoreCase)) { throw 'PATH_OUTSIDE_APPROVED_ROOT' }
    $cursor=Split-Path -Parent $candidate
    while ($cursor -and $cursor.Length -ge $Root.Length) {
        if ((Test-Path -LiteralPath $cursor -PathType Container) -and (Test-Reparse $cursor)) { throw 'ANCESTOR_REPARSE_POINT' }
        if ($cursor.Equals($Root,[StringComparison]::OrdinalIgnoreCase)) { break }
        $cursor=Split-Path -Parent $cursor
    }
    return $candidate
}
function Get-FileSnapshot([string]$Path) {
    $item=Get-Item -LiteralPath $Path -Force
    [pscustomobject]@{Length=[int64]$item.Length;LastWriteTimeUtc=$item.LastWriteTimeUtc.Ticks}
}
function Test-SnapshotEqual([object]$Before,[object]$After) {
    return ($Before.Length -eq $After.Length -and $Before.LastWriteTimeUtc -eq $After.LastWriteTimeUtc)
}
function Get-RecordEncoding([byte[]]$Bytes,[string]$EncodingHint) {
    if ($EncodingHint -eq 'UTF-8-BOM') { return New-Object Text.UTF8Encoding($true,$true) }
    if (@($Bytes | Where-Object { $_ -gt 0x7F }).Count -eq 0) { return New-Object Text.UTF8Encoding($false,$true) }
    try {
        $enc=New-Object Text.UTF8Encoding($false,$true)
        [void]$enc.GetString($Bytes)
        return $enc
    } catch {
        try {
            $enc=[Text.Encoding]::GetEncoding(949,[Text.EncoderFallback]::ExceptionFallback,[Text.DecoderFallback]::ExceptionFallback)
            [void]$enc.GetString($Bytes)
            return $enc
        } catch { throw 'UNSUPPORTED_ENCODING' }
    }
}
function Parse-CsvRecord([string]$Text) {
    $fields=New-Object Collections.Generic.List[string]
    $field=New-Object Text.StringBuilder
    $state='START'
    for ($i=0; $i -lt $Text.Length; $i++) {
        $c=$Text[$i]
        switch ($state) {
            'START' {
                if ($c -eq '"') { $state='QUOTED' }
                elseif ($c -eq ',') { $fields.Add('') }
                else { [void]$field.Append($c);$state='UNQUOTED' }
            }
            'UNQUOTED' {
                if ($c -eq ',') { $fields.Add($field.ToString());[void]$field.Clear();$state='START' }
                elseif ($c -eq '"') { throw 'MALFORMED_CSV_QUOTE' }
                else { [void]$field.Append($c) }
            }
            'QUOTED' {
                if ($c -eq '"') {
                    if ($i+1 -lt $Text.Length -and $Text[$i+1] -eq '"') { [void]$field.Append('"');$i++ }
                    else { $state='AFTER_QUOTE' }
                } else { [void]$field.Append($c) }
            }
            'AFTER_QUOTE' {
                if ($c -eq ',') { $fields.Add($field.ToString());[void]$field.Clear();$state='START' }
                else { throw 'MALFORMED_CSV_AFTER_QUOTE' }
            }
        }
    }
    if ($state -eq 'QUOTED') { throw 'MALFORMED_CSV_UNCLOSED_QUOTE' }
    $fields.Add($field.ToString())
    return $fields.ToArray()
}
function Get-HeaderStats([string[]]$Fields) {
    $empty=@()
    $duplicate=@()
    $seen=@{}
    for ($i=0; $i -lt $Fields.Count; $i++) {
        $key=$Fields[$i].Trim().ToUpperInvariant()
        if ([string]::IsNullOrWhiteSpace($Fields[$i])) { $empty+=($i+1) }
        elseif ($seen.ContainsKey($key)) { $duplicate+=($i+1) }
        else { $seen[$key]=$i+1 }
    }
    [pscustomobject]@{
        EmptyIndexes=$empty
        DuplicateIndexes=$duplicate
        TrailingEmpty=($Fields.Count -gt 0 -and [string]::IsNullOrWhiteSpace($Fields[$Fields.Count-1]))
    }
}
function Test-VersionPreamble([string[]]$Fields) {
    $nonEmpty=@($Fields | ForEach-Object {$_.Trim()} | Where-Object {$_})
    if ($nonEmpty.Count -lt 4) { return $false }
    if (-not $nonEmpty[0].Equals('VERSION',[StringComparison]::OrdinalIgnoreCase)) { return $false }
    return (@($nonEmpty | Where-Object {$_.Equals('VAR',[StringComparison]::OrdinalIgnoreCase)}).Count -gt 0)
}
function Test-VarexpSchema([string[]]$Fields) {
    if ($Fields.Count -ne 262) { return $false }
    $names=@{}
    foreach ($f in $Fields) { $key=$f.Trim().ToUpperInvariant();if ($key) {$names[$key]=$true} }
    if (-not $names.ContainsKey('CLASS') -or -not $names.ContainsKey('TAGNAME')) { return $false }
    $core=0
    foreach ($name in @('DOMAIN','NATURE','SOURCE')) { if ($names.ContainsKey($name)) {$core++} }
    if ($core -lt 2) { return $false }
    $family=$false
    foreach ($key in $names.Keys) { if ($key -match '(ALARM|OPC|BACNET|IEC104|IEC61850|SNMP|OPCUA)') {$family=$true;break} }
    if (-not $family) { return $false }
    $first=@($Fields | ForEach-Object {$_.Trim()} | Where-Object {$_} | Select-Object -First 1)
    if ($first.Count -eq 1 -and $first[0].Equals('VERSION',[StringComparison]::OrdinalIgnoreCase)) { return $false }
    return $true
}
function Test-PvTrendSchema([string[]]$Fields) {
    if ($Fields.Count -ne 6) { return $false }
    if (-not [string]::IsNullOrWhiteSpace($Fields[0])) { return $false }
    for ($i=1; $i -lt 6; $i++) { if ([string]::IsNullOrWhiteSpace($Fields[$i])) { return $false } }
    $patterns=@(
        '^(.*)\s+-\s+Minimum$',
        '^(.*)\s+-\s+Maximum$',
        '^(.*)\s+-\s+Weighted average$',
        '^(.*)\s+-\s+Minimum value.{0,2}s timestamp$',
        '^(.*)\s+-\s+Maximum value.{0,2}s timestamp$'
    )
    $base=$null
    for ($i=0; $i -lt 5; $i++) {
        if ($Fields[$i+1] -notmatch $patterns[$i]) { return $false }
        $candidate=$matches[1].Trim()
        if ($null -eq $base) {$base=$candidate} elseif (-not $base.Equals($candidate,[StringComparison]::Ordinal)) { return $false }
    }
    $stats=Get-HeaderStats $Fields
    return ($stats.EmptyIndexes.Count -eq 1 -and $stats.EmptyIndexes[0] -eq 1 -and $stats.DuplicateIndexes.Count -eq 0 -and -not $stats.TrailingEmpty)
}
function Read-LimitedDiscovery([string]$Path,[string]$Domain,[int]$MaxRecords,[int]$MaxBytes,[string]$SensitivePattern) {
    $stream=New-Object IO.FileStream($Path,[IO.FileMode]::Open,[IO.FileAccess]::Read,[IO.FileShare]::Read)
    $bytesRead=0
    $recordsRead=0
    $schemaIndex=0
    $stopReason='EOF_NO_SCHEMA'
    $encodingName='ASCII_COMPATIBLE'
    $bom='NONE'
    $schemaFields=$null
    $sensitive=$false
    $preamble=$false
    try {
        $prefix=New-Object Collections.Generic.List[byte]
        while ($prefix.Count -lt 3 -and $bytesRead -lt $MaxBytes) {
            $n=$stream.ReadByte()
            if ($n -lt 0) { break }
            $prefix.Add([byte]$n);$bytesRead++
        }
        if ($prefix.Count -eq 3 -and $prefix[0]-eq 0xEF -and $prefix[1]-eq 0xBB -and $prefix[2]-eq 0xBF) {
            $bom='UTF8';$encodingName='UTF-8-BOM'
        } else {
            $stream.Position=0;$bytesRead=0
        }
        $recordBytes=New-Object Collections.Generic.List[byte]
        $inQuotes=$false
        $complete=$false
        while ($recordsRead -lt $MaxRecords -and $bytesRead -lt $MaxBytes) {
            $n=$stream.ReadByte()
            if ($n -lt 0) {
                if ($recordBytes.Count -gt 0) {$complete=$true}
                else {$stopReason='EOF_NO_SCHEMA';break}
            } else {
                $bytesRead++
                if ($n -eq 0x22) {
                    if ($inQuotes) {
                        if ($stream.Position -lt $stream.Length -and $bytesRead -lt $MaxBytes) {
                            $peek=$stream.ReadByte()
                            if ($peek -eq 0x22) {$recordBytes.Add([byte]$n);$recordBytes.Add([byte]$peek);$bytesRead++;continue}
                            $stream.Position--
                        }
                        $inQuotes=$false
                    } else {$inQuotes=$true}
                    $recordBytes.Add([byte]$n)
                } elseif ($n -eq 0x0A -and -not $inQuotes) {
                    $complete=$true
                } else {$recordBytes.Add([byte]$n)}
            }
            if ($complete) {
                if ($recordBytes.Count -gt 0 -and $recordBytes[$recordBytes.Count-1] -eq 0x0D) {$recordBytes.RemoveAt($recordBytes.Count-1)}
                $recordsRead++
                $raw=$recordBytes.ToArray()
                $enc=Get-RecordEncoding $raw $encodingName
                if ($encodingName -eq 'ASCII_COMPATIBLE' -and @($raw | Where-Object {$_ -gt 0x7F}).Count -gt 0) {
                    if ($enc.CodePage -eq 65001) {$encodingName='UTF-8-NO-BOM'} else {$encodingName='WINDOWS-949'}
                }
                $text=$enc.GetString($raw)
                if ($text -match $SensitivePattern) {$sensitive=$true;$stopReason='SENSITIVE_PATTERN';break}
                $fields=Parse-CsvRecord $text
                if ($Domain -eq 'VAREXP') {
                    $isSchema=Test-VarexpSchema $fields
                    $isPreamble=Test-VersionPreamble $fields
                    if ($isSchema -and $isPreamble) {$stopReason='AMBIGUOUS_SIGNATURE';break}
                    if ($isSchema) {$schemaIndex=$recordsRead;$schemaFields=$fields;$stopReason='SCHEMA_FOUND';break}
                    if ($recordsRead -eq 1 -and $isPreamble) {$preamble=$true}
                } elseif ($Domain -eq 'PVTREND') {
                    if (Test-PvTrendSchema $fields) {$schemaIndex=1;$schemaFields=$fields;$stopReason='SCHEMA_FOUND'}
                    else {$stopReason='PVTREND_SCHEMA_MISMATCH'}
                    break
                }
                $recordBytes=New-Object Collections.Generic.List[byte]
                $complete=$false
                if ($n -lt 0) {$stopReason='EOF_NO_SCHEMA';break}
            }
        }
        if ($schemaIndex -eq 0 -and -not $sensitive) {
            if ($bytesRead -ge $MaxBytes) {$stopReason='BYTE_LIMIT_REACHED'}
            elseif ($recordsRead -ge $MaxRecords -and $stopReason -eq 'EOF_NO_SCHEMA') {$stopReason='RECORD_LIMIT_REACHED'}
        }
        [pscustomobject]@{LogicalRecordsRead=$recordsRead;BytesRead=$bytesRead;StopReason=$stopReason;SchemaRecordIndex=$schemaIndex;SchemaFields=$schemaFields;BOM=$bom;Encoding=$encodingName;Sensitive=$sensitive;PreambleDetected=$preamble;Error=$false}
    } catch {
        $failure=$_.Exception.Message
        if ($failure -notmatch '^(MALFORMED_CSV_|UNSUPPORTED_ENCODING)') {$failure='DISCOVERY_ERROR'}
        [pscustomobject]@{LogicalRecordsRead=$recordsRead;BytesRead=$bytesRead;StopReason=$failure;SchemaRecordIndex=0;SchemaFields=$null;BOM=$bom;Encoding=$encodingName;Sensitive=$false;PreambleDetected=$preamble;Error=$true}
    } finally {$stream.Dispose()}
}

$config=Import-PowerShellDataFile -LiteralPath $ConfigPath
$root=Get-ApprovedRoot $ProjectRoot
if (-not (Test-Path -LiteralPath $OutputRoot)) { New-Item -ItemType Directory -Path $OutputRoot | Out-Null }
$stamp=Get-Date -Format 'yyyyMMdd_HHmmss'
$work=Join-Path $OutputRoot ('PCVue_CSV_Header_Sample_'+$stamp)
New-Item -ItemType Directory -Path $work | Out-Null
$results=@()

foreach ($sample in $config.Samples) {
    $status='ERROR';$messageCode='UNEXPECTED_ERROR';$headers=@();$size='';$modified='';$sha='';$bom='';$encoding='';$delimiter='COMMA'
    $logicalRecordsRead=0;$bytesRead=0;$stopReason='NOT_STARTED';$schemaRecordIndex=0;$emptyIndexes=@();$duplicateIndexes=@();$trailingEmpty=$false;$headerParseStatus='NOT_PARSED'
    try {
        $file=Get-SafeSamplePath $root $sample.RelativePath
        if (-not (Test-Path -LiteralPath $file -PathType Leaf)) {$status='NOT_FOUND';$messageCode='NOT_FOUND';throw 'CONTROLLED_STATUS'}
        if (Test-Reparse $file) {throw 'FILE_REPARSE_POINT'}
        $before=Get-FileSnapshot $file
        $size=$before.Length
        $modified=(Get-Item -LiteralPath $file -Force).LastWriteTime.ToString('o')
        if ($size -gt [int64]$config.MaxFileBytes) {throw 'FILE_SIZE_LIMIT'}
        $sha=Get-Sha256 $file
        if ($sample.Domain -eq 'HISTO') {
            $status='MANUAL_FORMAT_REVIEW_REQUIRED';$messageCode='HISTO_PARSER_NOT_IMPLEMENTED';$stopReason='HISTO_CONTENT_NOT_ACCESSED'
            $logicalRecordsRead=0;$bytesRead=0;$schemaRecordIndex=0
        } else {
            $maxRecords=if ($sample.Domain -eq 'VAREXP') {[int]$config.MaxVarexpLogicalRecords} else {[int]$config.MaxPvTrendLogicalRecords}
            $discovery=Read-LimitedDiscovery $file $sample.Domain $maxRecords ([int]$config.MaxDiscoveryBytes) $config.SensitivePattern
            $logicalRecordsRead=$discovery.LogicalRecordsRead;$bytesRead=$discovery.BytesRead;$stopReason=$discovery.StopReason;$schemaRecordIndex=$discovery.SchemaRecordIndex;$bom=$discovery.BOM;$encoding=$discovery.Encoding
            if ($discovery.Error) {$status='ERROR';$messageCode=$stopReason;$headerParseStatus='MALFORMED_OR_UNSUPPORTED'}
            elseif ($discovery.Sensitive) {$status='SENSITIVE_REVIEW_REQUIRED';$messageCode='SENSITIVE_PATTERN_CATEGORY_CREDENTIAL_OR_SECRET'}
            elseif ($schemaRecordIndex -gt 0) {
                $headers=@($discovery.SchemaFields)
                $stats=Get-HeaderStats $headers
                $emptyIndexes=$stats.EmptyIndexes;$duplicateIndexes=$stats.DuplicateIndexes;$trailingEmpty=$stats.TrailingEmpty;$headerParseStatus='SYNTAX_VALID'
                if ($sample.Domain -eq 'PVTREND') {$status='APPROVED_STRUCTURE';$messageCode='PVTREND_SIX_COLUMN_SCHEMA'}
                elseif ($emptyIndexes.Count -gt 0 -or $duplicateIndexes.Count -gt 0) {$status='STRUCTURE_REVIEW_REQUIRED';$messageCode='VAREXP_SCHEMA_WITH_EMPTY_OR_DUPLICATE_COLUMNS'}
                else {$status='APPROVED_STRUCTURE';$messageCode='VAREXP_SCHEMA_CONFIRMED'}
            } else {
                $status='REVIEW_REQUIRED';$messageCode=$stopReason
                if ($stopReason -match '^MALFORMED') {$headerParseStatus='MALFORMED_CSV'}
            }
        }
        $after=Get-FileSnapshot $file
        if (-not (Test-SnapshotEqual $before $after)) {throw 'FILE_CHANGED_DURING_READ'}
    } catch {
        if ($_.Exception.Message -ne 'CONTROLLED_STATUS') {$status='ERROR';$messageCode=$_.Exception.Message;$stopReason='ERROR'}
    }
    $headerJson=if ($headers.Count -gt 0) {ConvertTo-Json -InputObject @($headers) -Compress} else {'[]'}
    $results+=[pscustomobject]@{
        Domain=$sample.Domain;RelativePath=$sample.RelativePath;FileName=[IO.Path]::GetFileName($sample.RelativePath)
        LengthBytes=$size;LastWriteTime=$modified;SHA256=$sha;BOM=$bom;Encoding=$encoding;Delimiter=$delimiter
        LOGICAL_RECORDS_READ=$logicalRecordsRead;BYTES_READ=$bytesRead;STOP_REASON=$stopReason;SCHEMA_RECORD_INDEX=$schemaRecordIndex;STRUCTURE_STATUS=$status
        ColumnCount=$headers.Count;EmptyHeaderColumnCount=$emptyIndexes.Count;EmptyHeaderColumnIndexes=($emptyIndexes -join ';')
        DuplicateHeaderCount=$duplicateIndexes.Count;DuplicateHeaderIndexes=($duplicateIndexes -join ';');TrailingEmptyColumn=$trailingEmpty
        HeaderParseStatus=$headerParseStatus;HeaderNamesJson=$headerJson;Status=$status;MessageCode=$messageCode
    }
}
$results | Export-Csv -LiteralPath (Join-Path $work 'CSV_SAMPLE_STRUCTURE.csv') -NoTypeInformation -Encoding UTF8
$results | Where-Object Domain -eq 'VAREXP' | Export-Csv -LiteralPath (Join-Path $work 'VAREXP_HEADER_ANALYSIS.csv') -NoTypeInformation -Encoding UTF8
$results | Where-Object Domain -eq 'HISTO' | Export-Csv -LiteralPath (Join-Path $work 'HISTO_HEADER_ANALYSIS.csv') -NoTypeInformation -Encoding UTF8
$results | Where-Object Domain -eq 'PVTREND' | Export-Csv -LiteralPath (Join-Path $work 'PVTREND_HEADER_ANALYSIS.csv') -NoTypeInformation -Encoding UTF8
$results | Select-Object Domain,RelativePath,LOGICAL_RECORDS_READ,BYTES_READ,STOP_REASON,SCHEMA_RECORD_INDEX,STRUCTURE_STATUS,MessageCode | Export-Csv -LiteralPath (Join-Path $work 'SAMPLE_COLLECTION_STATUS.csv') -NoTypeInformation -Encoding UTF8
$bad=@($results | Where-Object {$_.Status -ne 'APPROVED_STRUCTURE' -and $_.Status -ne 'MANUAL_FORMAT_REVIEW_REQUIRED'})
$final=if ($bad.Count -eq 0) {'APPROVED_STRUCTURE'} else {'REVIEW_REQUIRED'}
@(
 "FINAL_SAMPLE_STATUS=$final",
 "SAMPLE_COUNT=$($results.Count)",
 "APPROVED_COUNT=$(@($results | Where-Object Status -eq 'APPROVED_STRUCTURE').Count)",
 "MANUAL_FORMAT_REVIEW_COUNT=$(@($results | Where-Object Status -eq 'MANUAL_FORMAT_REVIEW_REQUIRED').Count)",
 "NON_APPROVED_COUNT=$($bad.Count)",
 'DATA_ROWS_STORED=0',
 'RAW_NON_SCHEMA_ROWS_STORED=0',
 'FIELD_USE=NOT_APPROVED'
) | Set-Content -LiteralPath (Join-Path $work 'FINAL_SAMPLE_STATUS.txt') -Encoding UTF8
$hashTargets=Get-ChildItem -LiteralPath $work -File | Sort-Object Name
@($hashTargets | ForEach-Object {"$((Get-Sha256 $_.FullName))  $($_.Name)"}) | Set-Content -LiteralPath (Join-Path $work 'SHA256SUMS.txt') -Encoding UTF8
Add-Type -AssemblyName System.IO.Compression.FileSystem
$zip=$work+'.zip'
[IO.Compression.ZipFile]::CreateFromDirectory($work,$zip,[IO.Compression.CompressionLevel]::Optimal,$false)
(Get-Sha256 $zip)+'  '+[IO.Path]::GetFileName($zip) | Set-Content -LiteralPath ($zip+'.sha256') -Encoding ASCII
Write-Host ("Sample ZIP: $zip")
Write-Host ("Final status: $final")
if ($bad.Count -gt 0) {exit 10}
exit 0
