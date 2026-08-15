# Windows PowerShell 5.1 End-to-End Validation Report

Date: 2026-08-13
Runtime: C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
Scope: nonProduction fixtures only

## Executed chain

RUN_SAMPLE_COLLECTOR.cmd -> Check-SampleCollector.ps1 -> Collect-PCVueCsvHeaders.ps1 -> VAREXP limited discovery -> PvTrend schema rule -> HISTO manual review -> seven result files -> ZIP -> external SHA-256.

## Results

| Check | Result |
|---|---|
| Static/security validation | PASS |
| Windows PowerShell 5.1 parsing and execution | PASS |
| Required seven ZIP entries | PASS |
| Internal SHA256SUMS | PASS |
| External ZIP SHA-256 | PASS |
| Source fixture unchanged | PASS |
| Read-boundary violations | 0 |
| Data-row sentinel in all ZIPs | 0 |
| HISTO second-record sentinel in all ZIPs | 0 |
| Unapproved CSV sentinel in all ZIPs | 0 |
| DAT/XLSX/XML sentinel in all ZIPs | 0 |
| Credential secret raw value in all ZIPs | 0 |

Collector exit code 10 is expected for fixture sets containing REVIEW_REQUIRED or ERROR outcomes; it is not an execution-chain failure.

Production SCADA execution was not performed.
