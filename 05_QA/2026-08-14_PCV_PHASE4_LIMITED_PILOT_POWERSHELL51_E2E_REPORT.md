# Windows PowerShell 5.1 End-to-End Report

Runtime: C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
Date: 2026-08-14
Environment: nonProduction fixtures only

## Chain

RUN_LIMITED_PILOT.cmd -> Check-PilotCollector.ps1 -> Collect-LimitedVarexpTags.ps1 -> schema verification -> bounded data records -> 17-field positional output -> hashes -> ZIP.

## Result

- Static/security validation: PASS
- Launcher-to-ZIP execution: PASS
- Positive fixture: PASS, 100 emitted rows
- Schema-first and VERSION+schema: PASS
- Quoted comma, embedded quote, multiline, empty value: PASS
- UTF-8 BOM and ASCII-compatible: PASS
- Result ZIP entries and internal/external hashes: PASS
- Source modification: 0
- Production execution: not performed

Expected fixture rejection scenarios return REVIEW_REQUIRED and nonzero exit without breaking ZIP/hash generation.

Final: PASS
