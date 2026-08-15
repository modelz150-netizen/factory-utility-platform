@{
 SchemaVersion='1.0'
 MaxSchemaRecords=3
 MaxSchemaBytes=65536
 MaxDataRecordsPerFile=100
 MaxDataBytesPerFile=262144
 MaxTotalEmitRows=100
 MaxFileBytes=5242880
 SensitivePattern='(?i)(password|passwd|pwd|credential|secret|token|private.?key|api.?key|certificate|connection.?string|opc(?:ua)?[:/]|https?://|\\|(?:^|[^0-9])(?:25[0-5]|2[0-4][0-9]|1?[0-9]{1,2})(?:\.(?:25[0-5]|2[0-4][0-9]|1?[0-9]{1,2})){3}(?:[^0-9]|$))'
 AllowPositions=@(1,2,16,17,18,19,20,21,22,47,48,51,52,66,73,163,166)
 Sources=@(
  @{SourceFileId='VAREXP_01';RelativePath='USR\SSV Integrated Project\C1\Shared\varexp_main.csv'}
  @{SourceFileId='VAREXP_02';RelativePath='USR\SSV Integrated Project\C1\Shared\A\varexp\plc_m_varexp.csv'}
  @{SourceFileId='VAREXP_03';RelativePath='USR\SSV Integrated Project\C1\Shared\B\varexp\G03_varexp.csv'}
  @{SourceFileId='VAREXP_04';RelativePath='USR\SSV Integrated Project\C1\Shared\C\varexp\BFU_varexp.csv'}
  @{SourceFileId='VAREXP_05';RelativePath='USR\SSV Integrated Project\C1\Shared\ELEC\varexp\E02_varexp.csv'}
 )
}
