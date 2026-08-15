# Phase 4.2 Windows PowerShell 5.1 E2E Report

| Field | Result |
|---|---|
| Runtime | Windows PowerShell 5.1.19041.6456 |
| Path | RUN_LIMITED_PILOT.cmd → Checker → Collector → context discovery → 20-field projection → identity analysis → ZIP/SHA |
| Static/security | PASS |
| Final E2E | PASS |
| Files | 5/5 |
| Rows | 20/file, 100 total |
| ZIP integrity | PASS |
| Internal/external SHA-256 | PASS/PASS |
| Production execution | NOT PERFORMED |

VERSION+schema sources VAREXP_01/03/04 reached schema record 2 and emitted 20 rows each. Schema-first VAREXP_02/05 reached schema record 1. No service/process/network/DB/PLC/OPC action occurred.
