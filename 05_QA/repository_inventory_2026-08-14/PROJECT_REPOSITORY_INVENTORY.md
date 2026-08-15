# Project Repository Inventory

| Field | Value |
|---|---|
| Date | 2026-08-14 |
| Mode | Read-only inventory; no move/delete/rename/stage/commit/push/fetch |
| Repository | C:\Users\405880\Documents\Codex\factory-utility-platform |
| Files excluding .git | 4,357 |
| Size excluding .git | 408,682,082 bytes |
| Git tracked / untracked | 215 / 4,142 |

## Top-level inventory

| Path | FileCount | Size | GitTracked | GitUntracked | Classification | Purpose | RecommendedAction |
|---|---:|---:|---:|---:|---|---|---|
| 00_Governance | 28 | 223,381 B | 27 | 1 | Governance | Standards, decisions, status | KEEP; review 3 modified tracked files before any commit |
| 01_Product | 3 | 30,493 B | 3 | 0 | Documentation | Product requirements | KEEP |
| 02. Project Backup | 3,601 | 401,246,873 B | 0 | 3,601 | Production/Field Evidence possible | PLC/HMI/SCADA and reference backups | MOVE_LATER to controlled evidence vault; add ignore before staging anything |
| 03_Development | 138 | 538,495 B | 99 | 39 | Source Code/Architecture | Platform and PCVue Collector tools | KEEP source; separate generated Output |
| 04_Design | 3 | 24,556 B | 3 | 0 | Design | Design system | KEEP |
| 05_QA | 495 | 5,970,439 B | 79 | 416 | QA/Test, fixture, generated output | Reports, fixtures and execution results | KEEP concise reports/synthetic fixtures; IGNORE generated execution output |
| 07_Release | 67 | 357,133 B | 0 | 67 | Release | Packages, checksums, Gate documents | Track approved manifests/reports; publish binary ZIP as release asset later |
| usb | 17 | 158,305 B | 0 | 17 | Release staging | USB deployment copy | IGNORE/MOVE_LATER; not source of truth |
| root documents | 4 | 132,382 B | 4 | 0 | Governance/Documentation | README, Charter, AGENTS, gitignore | KEEP |
| .codex-write-test.txt | 1 | 25 B | 0 | 1 | Temporary | Workspace probe | DELETE_CANDIDATE after approval |

## Major evidence/backup folders

| Path | Files | Size | Git state | Assessment |
|---|---:|---:|---|---|
| 02. Project Backup/Factory C | 1,457 | 36,250,557 B | UNTRACKED | Field/engineering backup candidate |
| 02. Project Backup/Factory B | 883 | 20,306,005 B | UNTRACKED | Field/engineering backup candidate |
| 02. Project Backup/S7_reference | 501 | 39,593,840 B | UNTRACKED | PLC reference/project material |
| 02. Project Backup/PLC Backup F.A | 231 | 22,278,360 B | UNTRACKED | PLC backup |
| 02. Project Backup/01. Weintek | 167 | 213,251,820 B | UNTRACKED | HMI project/compiled backups |
| 02. Project Backup/Factory A | 164 | 17,052,759 B | UNTRACKED | Field/engineering backup candidate |
| 02. Project Backup/Cimon | 161 | 6,127,050 B | UNTRACKED | PLC/HMI project material |
| 05_QA/phase4_2_minimal_hierarchy_pilot_rc1 | 158 | 2,139,060 B | UNTRACKED | Synthetic fixture and generated QA output |
| 05_QA/rc5_nonproduction | 144 | 677,216 B | UNTRACKED | Phase 3 synthetic fixture/output |
| 05_QA/varexp_limited_pilot_rc1 | 99 | 919,864 B | UNTRACKED | Phase 4 synthetic fixture/output |

## Phase 3–4.2 inventory

| Scope | Files | Tracked | Untracked | Main locations |
|---|---:|---:|---:|---|
| RC6/RC6.1 | 8 | 0 | 8 | 03_Development/tools, 05_QA, 07_Release, usb |
| Phase 3 | 34 | 0 | 34 | 05_QA/rc5_nonproduction, 07_Release/phase3_*, Header Collector RC5 |
| Phase 4 broad match | 189 | 0 | 189 | Phase 4 Gate documents, VAREXP Collector/QA outputs |
| Phase 4.1 | 7 | 0 | 7 | 07_Release/phase4_1_varexp_identity_gate |
| Phase 4.2 | 174 | 0 | 174 | 03_Development/tools, 05_QA/phase4_2_*, 07_Release |
| SHA-256 material | 64 | 1 | 63 | Package baselines, QA outputs, Release sidecars |

The same release package source is repeated in Development, Release, QA release_recheck and sometimes USB staging. These copies are not all independent authoritative artifacts.

## Duplicate evidence

Content hashing found 463 duplicate groups and about 29,762,805 duplicate bytes. The largest group contains 42 identical PLC FBI files. Duplicate status is an inventory finding only; no deletion decision has been made.
