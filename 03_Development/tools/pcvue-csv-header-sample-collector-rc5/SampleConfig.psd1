@{
    SchemaVersion = '1.1'
    MaxDiscoveryBytes = 65536
    MaxVarexpLogicalRecords = 3
    MaxPvTrendLogicalRecords = 1
    MaxFileBytes = 5242880
    SensitivePattern = '(?i)(password|passwd|pwd|credential|secret|token|private.?key|license.?key|activation|connection.?string|api.?key)'
    Samples = @(
        @{ Domain='VAREXP'; RelativePath='USR\SSV Integrated Project\C1\Shared\varexp_main.csv' }
        @{ Domain='VAREXP'; RelativePath='USR\SSV Integrated Project\C1\Shared\A\varexp\plc_m_varexp.csv' }
        @{ Domain='VAREXP'; RelativePath='USR\SSV Integrated Project\C1\Shared\B\varexp\G03_varexp.csv' }
        @{ Domain='VAREXP'; RelativePath='USR\SSV Integrated Project\C1\Shared\C\varexp\BFU_varexp.csv' }
        @{ Domain='VAREXP'; RelativePath='USR\SSV Integrated Project\C1\Shared\ELEC\varexp\E02_varexp.csv' }
        @{ Domain='HISTO'; RelativePath='USR\SSV Integrated Project\C1\Server Station\histo_log.csv' }
        @{ Domain='HISTO'; RelativePath='USR\SSV Integrated Project\C1\Shared\A\histo\plc_w_histo.csv' }
        @{ Domain='HISTO'; RelativePath='USR\SSV Integrated Project\C1\Shared\B\histo\G02_histo.csv' }
        @{ Domain='HISTO'; RelativePath='USR\SSV Integrated Project\C1\Shared\C\histo\C11_histo.csv' }
        @{ Domain='HISTO'; RelativePath='USR\SSV Integrated Project\C1\Shared\ELEC\histo\E02_histo.csv' }
        @{ Domain='PVTREND'; RelativePath='USR\SSV Integrated Project\TP\PvTrend_AggregatedStatistics_202506121757.csv' }
    )
}
