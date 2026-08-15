# .gitignore Application Report

Date: 2026-08-14

The Gate 1 policy was applied. Narrow rules were added for actual QA execution-product paths, while `/07_Release/*.zip.sha256` was explicitly re-included as durable evidence.

| Population | Count | Correct result |
|---|---:|---:|
| TRACK_IN_GIT candidates | 182 | 182 visible; incorrectly ignored 0 |
| IGNORE_GENERATED candidates | 347 | 347 ignored |

Production backup, USB staging, runtime outputs, extraction/recheck and temporary products are ignored. Source, Governance, Architecture, Design, durable QA, safe synthetic fixtures, contracts and release checksums remain visible.

Result: **PASS**