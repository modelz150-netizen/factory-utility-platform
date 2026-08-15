# PCV-001 RC6.1 Operator Configuration Test Report

| Field | Value |
|---|---|
| Date | 2026-08-12 |
| Backlog | `PCV-001` |
| Scope | PCVue Offline Data Collector V1 1.0.0-rc6.1 |
| Environment | Windows 10; Windows PowerShell 5.1.19041.6456 |
| Executor | Codex engineering agent |
| Result | PASS |

## Executed validation

The package static validator and `Test-RC61OperatorConfiguration.ps1` were actually executed using `%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe`.

| Check | Observed result |
|---|---|
| PowerShell 5.1 parse | PASS |
| `D:\Project Files` policy fixture | PASS — `POLICY_ACCEPTED` as an absolute local-path input; physical Production path was not accessed |
| Drive root, UNC, Windows, Users and relative paths | PASS — rejected with explicit reasons |
| Mutable file changed after packaging | PASS — static validation continued while immutable files remained valid |
| Collector tamper | PASS — checksum mismatch failed closed before execution |
| Mutable file reinserted into immutable baseline | PASS — static validation rejected the package |
| Runtime mutable configuration SHA-256 | PASS — matched `OPERATOR_CONFIGURATION_AUDIT.csv` |
| Result Manifest | PASS — operator audit artifact present and SHA-256 covered |
| Root evidence | PASS — `OPERATOR_APPROVED` with path hash and accepted result present |
| Static prohibited-command/security scan | PASS — 2 PowerShell files; no prohibited command or external executable call |
| Final deployment ZIP extraction/static validation | PASS |
| External ZIP SHA-256 | PASS — `8f50f3326ec9e0388ba6ff6565cdb77bb86aa1b6ad7e6c41065ed52af74059dd` |
| Prior collection data exclusion | PASS — 0 collection-output files in deployment ZIP |

## Test assets

- Fixture: `05_QA/fixtures/PCV-RC61/AdditionalProjectRoots.txt`
- Regression runner: `03_Development/tools/pcvue-offline-data-collector-v1/Test-RC61OperatorConfiguration.ps1`

## Known gaps and operational guard

- `D:\Project Files` does not exist in the development environment, so the fixture verifies Windows PowerShell 5.1 policy acceptance, not Production content collection.
- Runtime audit was exercised with an isolated non-system local fixture directory and removed after the test.
- Production SCADA was not accessed or executed.
- Field use remains `NOT APPROVED` pending the existing human OT/security release gate.
