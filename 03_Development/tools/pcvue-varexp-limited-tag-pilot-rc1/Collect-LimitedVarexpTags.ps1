#requires -version 5.1
[CmdletBinding()]
param(
 [AllowNull()][object]$ProjectRoot='D:\Project Files',
 [AllowNull()][object]$OutputRoot,
 [AllowNull()][object]$ConfigPath
)
$ErrorActionPreference='Stop'
Set-StrictMode -Version 2.0
function Stop-PathFailure([string]$Name,[string]$Reason){Write-Host ("[ERROR] Invalid {0}: {1}" -f $Name,$Reason);exit 2}
function Get-SinglePath([object]$Value,[string]$Name,[bool]$AllowMissing){
 if($Value-is[Array]){Stop-PathFailure $Name 'multiple values'}
 if($null-eq$Value){if($AllowMissing){return $null};Stop-PathFailure $Name 'null'}
 if($Value-isnot[string]){Stop-PathFailure $Name 'not string'}
 $t=[string]$Value
 if([string]::IsNullOrWhiteSpace($t)){if($AllowMissing){return $null};Stop-PathFailure $Name 'empty'}
 if($t.IndexOf([char]0)-ge 0-or$t.IndexOf([char]10)-ge 0-or$t.IndexOf([char]13)-ge 0-or$t.IndexOf([char]34)-ge 0){Stop-PathFailure $Name 'malformed'}
 try{return [IO.Path]::GetFullPath($t)}catch{Stop-PathFailure $Name 'normalization failure'}
}
$scriptRoot=Get-SinglePath $PSScriptRoot 'PSScriptRoot' $false
$projectRootText=Get-SinglePath $ProjectRoot 'ProjectRoot' $false
$outputRootText=Get-SinglePath $OutputRoot 'OutputRoot' $true
$configPathText=Get-SinglePath $ConfigPath 'ConfigPath' $true
if($null-eq$outputRootText){$outputRootText=[IO.Path]::GetFullPath((Join-Path $scriptRoot 'Pilot_Output'))}
if($null-eq$configPathText){$configPathText=[IO.Path]::GetFullPath((Join-Path $scriptRoot 'PilotConfig.psd1'))}
if(-not(Test-Path -LiteralPath $configPathText -PathType Leaf)){Stop-PathFailure 'ConfigPath' 'missing'}
function Get-Sha256([string]$Path){(Get-FileHash -LiteralPath $Path -Algorithm SHA256).Hash.ToUpperInvariant()}
function Get-BytesSha256([byte[]]$Bytes){$sha=[Security.Cryptography.SHA256]::Create();try{([BitConverter]::ToString($sha.ComputeHash($Bytes))).Replace('-','')}finally{$sha.Dispose()}}
function Test-Reparse([string]$Path){((Get-Item -LiteralPath $Path -Force).Attributes-band[IO.FileAttributes]::ReparsePoint)-ne 0}
function Get-ApprovedRoot([string]$Path){
 if([string]::IsNullOrWhiteSpace($Path)-or$Path.StartsWith('\\')-or$Path.StartsWith('\\?\')-or$Path.StartsWith('\\.\')){throw 'UNC_OR_DEVICE_PATH'}
 if(-not[IO.Path]::IsPathRooted($Path)){throw 'ROOT_NOT_ABSOLUTE'}
 $full=[IO.Path]::GetFullPath($Path).TrimEnd('\')
 if(-not(Test-Path -LiteralPath $full -PathType Container)){throw 'ROOT_NOT_FOUND'}
 if(Test-Reparse $full){throw 'ROOT_REPARSE_POINT'}
 $drive=New-Object IO.DriveInfo([IO.Path]::GetPathRoot($full))
 if($drive.DriveType-ne[IO.DriveType]::Fixed){throw 'ROOT_NOT_FIXED_DRIVE'}
 return $full
}
function Get-SafePath([string]$Root,[string]$RelativePath){
 if([IO.Path]::IsPathRooted($RelativePath)-or$RelativePath.Contains('..')-or$RelativePath-notmatch'(?i)\.csv$'){throw 'INVALID_RELATIVE_PATH'}
 $candidate=[IO.Path]::GetFullPath((Join-Path $Root $RelativePath));$prefix=$Root.TrimEnd('\')+'\'
 if(-not$candidate.StartsWith($prefix,[StringComparison]::OrdinalIgnoreCase)){throw 'OUTSIDE_ROOT'}
 $cursor=Split-Path -Parent $candidate
 while($cursor-and$cursor.Length-ge$Root.Length){if((Test-Path -LiteralPath $cursor -PathType Container)-and(Test-Reparse $cursor)){throw 'REPARSE_ANCESTOR'};if($cursor.Equals($Root,[StringComparison]::OrdinalIgnoreCase)){break};$cursor=Split-Path -Parent $cursor}
 return $candidate
}
function Get-Snapshot([string]$Path){$i=Get-Item -LiteralPath $Path -Force;[pscustomobject]@{Length=[int64]$i.Length;Ticks=$i.LastWriteTimeUtc.Ticks}}
function Read-Record([IO.FileStream]$Stream,[int64]$Limit){
 $list=New-Object Collections.Generic.List[byte];$read=0L;$quoted=$false;$complete=$false;$eof=$false
 while($read-lt$Limit){
  $n=$Stream.ReadByte()
  if($n-lt 0){$eof=$true;if($list.Count-gt 0){$complete=$true};break}
  $read++
  if($n-eq 0x22){
   if($quoted-and$Stream.Position-lt$Stream.Length-and$read-lt$Limit){$peek=$Stream.ReadByte();if($peek-eq 0x22){$list.Add([byte]$n);$list.Add([byte]$peek);$read++;continue}else{$Stream.Position--}}
   $quoted=-not$quoted;$list.Add([byte]$n)
  }elseif($n-eq 0x0A-and-not$quoted){$complete=$true;break}else{$list.Add([byte]$n)}
 }
 if($complete-and$list.Count-gt 0-and$list[$list.Count-1]-eq 0x0D){$list.RemoveAt($list.Count-1)}
 [pscustomobject]@{Bytes=$list.ToArray();BytesRead=$read;Complete=$complete;Eof=$eof;Boundary=(-not$complete-and$read-ge$Limit)}
}
function Decode-Record([byte[]]$Bytes,[string]$EncodingName){
 if($EncodingName-eq'UTF-8-BOM'-or$EncodingName-eq'UTF-8-NO-BOM'){$enc=New-Object Text.UTF8Encoding($false,$true)}
 else{$enc=New-Object Text.UTF8Encoding($false,$true)}
 try{return $enc.GetString($Bytes)}catch{throw 'UNSUPPORTED_ENCODING'}
}
function Parse-Record([string]$Text){
 $fields=New-Object Collections.Generic.List[string];$field=New-Object Text.StringBuilder;$state='START'
 for($i=0;$i-lt$Text.Length;$i++){$c=$Text[$i];switch($state){
  'START'{if($c-eq'"'){$state='QUOTED'}elseif($c-eq','){$fields.Add('')}else{[void]$field.Append($c);$state='UNQUOTED'}}
  'UNQUOTED'{if($c-eq','){$fields.Add($field.ToString());[void]$field.Clear();$state='START'}elseif($c-eq'"'){throw 'MALFORMED_QUOTE'}else{[void]$field.Append($c)}}
  'QUOTED'{if($c-eq'"'){if($i+1-lt$Text.Length-and$Text[$i+1]-eq'"'){[void]$field.Append('"');$i++}else{$state='AFTER_QUOTE'}}else{[void]$field.Append($c)}}
  'AFTER_QUOTE'{if($c-eq','){$fields.Add($field.ToString());[void]$field.Clear();$state='START'}else{throw 'MALFORMED_AFTER_QUOTE'}}
 }}
 if($state-eq'QUOTED'){throw 'MALFORMED_UNCLOSED_QUOTE'};$fields.Add($field.ToString());return $fields.ToArray()
}
function Test-Version([string[]]$Fields){$n=@($Fields|ForEach-Object{$_.Trim()}|Where-Object{$_});return($n.Count-ge 4-and$n[0].Equals('VERSION',[StringComparison]::OrdinalIgnoreCase)-and@($n|Where-Object{$_.Equals('VAR',[StringComparison]::OrdinalIgnoreCase)}).Count-gt 0)}
function Test-Schema([string[]]$Fields){
 if($Fields.Count-ne 262){return $false};$set=@{};foreach($f in $Fields){$k=$f.Trim().ToUpperInvariant();if($k){$set[$k]=$true}}
 return($set.ContainsKey('CLASS')-and$set.ContainsKey('TAGNAME')-and$set.ContainsKey('DOMAIN')-and$set.ContainsKey('NATURE')-and$set.ContainsKey('SOURCE'))
}
function New-OutputRow([string]$SourceFileId,[string]$Variant,[string]$SchemaHash,[int]$RecordIndex,[string[]]$Schema,[string[]]$Fields,[int[]]$Positions){
 $o=[ordered]@{SourceFileId=$SourceFileId;SchemaVariant=$Variant;SchemaHash=$SchemaHash;SourceRecordIndex=$RecordIndex}
 foreach($p in $Positions){$id=('VAREXP_COL_{0:D3}'-f$p);$o[$id+'_OriginalHeader']=$Schema[$p-1];$o[$id+'_Value']=$Fields[$p-1]}
 return [pscustomobject]$o
}
$config=Import-PowerShellDataFile -LiteralPath $configPathText
$root=Get-ApprovedRoot $projectRootText
if(-not(Test-Path -LiteralPath $outputRootText)){New-Item -ItemType Directory -Path $outputRootText|Out-Null}
$stamp=Get-Date -Format 'yyyyMMdd_HHmmss';$work=Join-Path $outputRootText('PCVue_VAREXP_Limited_Tag_Pilot_'+$stamp);New-Item -ItemType Directory -Path $work|Out-Null
$rows=@();$files=@();$schemas=@();$totalEmit=0
foreach($source in $config.Sources){
 $status='ERROR';$stop='NOT_STARTED';$schemaIndex=0;$schemaHash='';$variant='';$dataRead=0;$dataBytes=0L;$emitted=0;$rejected=0;$fileSha='';$schema=$null
 try{
  if($totalEmit-ge[int]$config.MaxTotalEmitRows){$status='NOT_PROCESSED';$stop='TOTAL_EMIT_LIMIT_REACHED';throw 'CONTROLLED'}
  $file=Get-SafePath $root $source.RelativePath
  if(-not(Test-Path -LiteralPath $file -PathType Leaf)-or(Test-Reparse $file)){throw 'FILE_NOT_SAFE'}
  $before=Get-Snapshot $file;if($before.Length-gt[int64]$config.MaxFileBytes){throw 'FILE_SIZE_LIMIT'};$fileSha=Get-Sha256 $file
  $stream=New-Object IO.FileStream($file,[IO.FileMode]::Open,[IO.FileAccess]::Read,[IO.FileShare]::Read)
  try{
   $encoding='ASCII_COMPATIBLE';$first=New-Object byte[] 3;$got=$stream.Read($first,0,3)
   if($got-eq 3-and$first[0]-eq0xEF-and$first[1]-eq0xBB-and$first[2]-eq0xBF){$encoding='UTF-8-BOM'}else{$stream.Position=0}
   $schemaBytes=0L
   for($si=1;$si-le[int]$config.MaxSchemaRecords;$si++){
    $remaining=[int64]$config.MaxSchemaBytes-$schemaBytes;if($remaining-le 0){break}
    $rr=Read-Record $stream $remaining;$schemaBytes+=$rr.BytesRead
    if(-not$rr.Complete){break};$text=Decode-Record $rr.Bytes $encoding
    if($text-match$config.SensitivePattern){$status='SENSITIVE_REVIEW_REQUIRED';$stop='SENSITIVE_SCHEMA_RECORD';throw 'CONTROLLED'}
    $f=Parse-Record $text
    if(Test-Schema $f){$schema=$f;$schemaIndex=$si;$schemaHash=Get-BytesSha256 $rr.Bytes;$variant=('SCHEMA_RECORD_{0}'-f$si);$stop='SCHEMA_VERIFIED';break}
    if($si-eq1-and-not(Test-Version $f)){$stop='SCHEMA_NOT_FOUND'}
   }
   if($null-eq$schema){if($status-ne'SENSITIVE_REVIEW_REQUIRED'){$status='REVIEW_REQUIRED';$stop='SCHEMA_NOT_VERIFIED'};throw 'CONTROLLED'}
   $schemas+=[pscustomobject]@{SourceFileId=$source.SourceFileId;SchemaVariant=$variant;SchemaHash=$schemaHash;SchemaRecordIndex=$schemaIndex;ColumnCount=$schema.Count;FileSHA256=$fileSha}
   $status='PASS'
   while($dataRead-lt[int]$config.MaxDataRecordsPerFile-and$dataBytes-lt[int64]$config.MaxDataBytesPerFile-and$totalEmit-lt[int]$config.MaxTotalEmitRows){
    $remaining=[int64]$config.MaxDataBytesPerFile-$dataBytes;$rr=Read-Record $stream $remaining;$dataBytes+=$rr.BytesRead
    if($rr.Boundary){$status='REVIEW_REQUIRED';$stop='DATA_BYTE_LIMIT_REACHED';break}
    if(-not$rr.Complete){$stop=if($rr.Eof){'EOF'}else{'INCOMPLETE_RECORD'};break}
    $dataRead++;$text=Decode-Record $rr.Bytes $encoding
    if($text-match$config.SensitivePattern){$status='SENSITIVE_REVIEW_REQUIRED';$stop='SENSITIVE_DATA_RECORD';$rejected++;break}
    $f=Parse-Record $text
    if($f.Count-ne 262){$status='REVIEW_REQUIRED';$stop=('FIELD_COUNT_{0}'-f$f.Count);$rejected++;break}
    $rows+=New-OutputRow $source.SourceFileId $variant $schemaHash $dataRead $schema $f @($config.AllowPositions)
    $emitted++;$totalEmit++
   }
   if($status-eq'PASS'){
    if($totalEmit-ge[int]$config.MaxTotalEmitRows){$stop='TOTAL_EMIT_LIMIT_REACHED'}
    elseif($dataRead-ge[int]$config.MaxDataRecordsPerFile){$stop='DATA_RECORD_LIMIT_REACHED'}
    elseif($dataBytes-ge[int64]$config.MaxDataBytesPerFile){$stop='DATA_BYTE_LIMIT_REACHED'}
    elseif($stop-eq'SCHEMA_VERIFIED'){$stop='EOF'}
   }
  }finally{if($null-ne$stream){$stream.Dispose()}}
  $after=Get-Snapshot $file;if($before.Length-ne$after.Length-or$before.Ticks-ne$after.Ticks){throw 'SOURCE_CHANGED'}
 }catch{if($_.Exception.Message-ne'CONTROLLED'){$status='ERROR';$stop=$_.Exception.Message}}
 $files+=[pscustomobject]@{SourceFileId=$source.SourceFileId;FileSHA256=$fileSha;SchemaVariant=$variant;SchemaHash=$schemaHash;SchemaRecordIndex=$schemaIndex;DATA_LOGICAL_RECORDS_READ=$dataRead;DATA_BYTES_READ=$dataBytes;EMITTED_ROWS=$emitted;REJECTED_ROWS=$rejected;STOP_REASON=$stop;STATUS=$status}
}
$rows|Export-Csv -LiteralPath(Join-Path $work 'TAG_DATA.csv')-NoTypeInformation -Encoding UTF8
$files|Export-Csv -LiteralPath(Join-Path $work 'FILE_STATUS.csv')-NoTypeInformation -Encoding UTF8
$schemas|Export-Csv -LiteralPath(Join-Path $work 'SCHEMA_PROVENANCE.csv')-NoTypeInformation -Encoding UTF8
$bad=@($files|Where-Object STATUS -ne 'PASS')
$final=if($bad.Count-eq0){'PASS'}else{'REVIEW_REQUIRED'}
@("FINAL_STATUS=$final","SOURCE_FILE_COUNT=$($files.Count)","EMITTED_TAG_ROWS=$($rows.Count)",'ALLOWED_POSITIONAL_FIELDS=17','RAW_ROWS_STORED=0','EXCLUDED_FIELD_VALUES_STORED=0','CREDENTIAL_SECRET_RAW_VALUES_STORED=0','FULL_PATHS_STORED=0','PRODUCTION_EXECUTION=NOT_APPROVED')|Set-Content -LiteralPath(Join-Path $work 'FINAL_STATUS.txt')-Encoding UTF8
$targets=Get-ChildItem -LiteralPath $work -File|Sort-Object Name;@($targets|ForEach-Object{"$((Get-Sha256 $_.FullName))  $($_.Name)"})|Set-Content -LiteralPath(Join-Path $work 'SHA256SUMS.txt')-Encoding UTF8
Add-Type -AssemblyName System.IO.Compression.FileSystem;$zip=$work+'.zip';[IO.Compression.ZipFile]::CreateFromDirectory($work,$zip,[IO.Compression.CompressionLevel]::Optimal,$false)
(Get-Sha256 $zip)+'  '+[IO.Path]::GetFileName($zip)|Set-Content -LiteralPath($zip+'.sha256')-Encoding ASCII
Write-Host("Pilot ZIP: $zip");Write-Host("Final status: $final");if($bad.Count-gt0){exit 10};exit 0
