# Production Data Git Risk Assessment

| Field | Value |
|---|---|
| Date | 2026-08-14 |
| Method | Path/name classification plus bounded text-pattern detection; no sensitive values retained |
| Overall risk | HIGH until ignore/evidence boundaries are established |

## Findings

| Data type | Finding | Git state | Risk |
|---|---|---|---|
| Known actual PCVue Production result timestamps | 0 files inside repository | NOT PRESENT | No current Git inclusion |
| SCADA/PLC/HMI backup or source | 3,601 files, 401,246,873 B under 02. Project Backup | UNTRACKED | Critical accidental-stage risk |
| Alarm-related material | 51 files | UNTRACKED | Could include alarm logic/history; provenance review required |
| Trend-related material | 15 path matches; mostly QA fixture/header evidence | 14 UNTRACKED, 1 unrelated tracked source file | Separate fixtures from field data |
| Tag/variable material | 382 path matches | UNTRACKED | Includes PLC VAR and synthetic VAREXP/TAG_DATA outputs |
| Network/endpoint configuration by filename | OPC_2021_10_02.csv | UNTRACKED | Potential OT endpoint/address material |
| Network-value pattern in non-fixture backup text | Several OPC/S7 reference files | UNTRACKED | Do not print or commit without review |
| Credential/key/certificate filename matches | Mostly code tokens and QA negative fixtures | mixed | Filename match alone is not proof of a real secret |
| Private-key block pattern | No confirmed private-key block reported | — | Continue dedicated secret scanning before any commit |

The real Production result files referenced in earlier field work are outside this repository and were not found under their known timestamps in the worktree. Their current external-drive existence was not revalidated during this inventory.

## Required controls before migration

1. Deny-by-default ignore for 02. Project Backup, Production evidence, Collector Output and USB staging.
2. Pre-commit secret scan and path-policy scan.
3. Separate encrypted evidence vault with access log, retention, classification and SHA-256 manifest.
4. Synthetic fixtures must carry a SYNTHETIC marker and contain no copied Production rows.
5. No Git LFS assumption for OT evidence: LFS still publishes sensitive content to Git hosting.
6. Manual allowlist review for every exception.

No data was moved, deleted, staged or modified by this assessment.
