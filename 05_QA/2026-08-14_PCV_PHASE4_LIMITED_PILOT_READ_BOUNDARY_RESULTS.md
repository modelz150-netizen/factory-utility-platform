# Phase 4 Limited Pilot Read Boundary Results

| Scenario | Source/result | Records | Bytes | Emitted | Stop | Result |
|---|---|---:|---:|---:|---|---|
| Production-config positive | Each VAREXP_01..04 | 20 | 8576 | 20 | DATA_RECORD_LIMIT_REACHED | PASS |
| Production-config positive | VAREXP_05 | 20 | 8576 | 20 | TOTAL_EMIT_LIMIT_REACHED | PASS |
| 261 fields | VAREXP_03 | 1 | 424 | 0 | FIELD_COUNT_261 | PASS |
| 263 fields | VAREXP_04 | 1 | 431 | 0 | FIELD_COUNT_263 | PASS |
| 256 KiB | VAREXP_01 | 0 complete | 262144 | 0 | DATA_BYTE_LIMIT_REACHED | PASS |
| Sensitive | VAREXP_01 | 1 | 435 | 0 | SENSITIVE_DATA_RECORD | PASS |
| Global 101st attempt | Total | 100 | within per-file byte limit | 100 | TOTAL_EMIT_LIMIT_REACHED | PASS |

Violations: 0. The special global-boundary fixture increases only its nonProduction per-file record setting so the global 101st-attempt guard can be exercised; the immutable release config remains 20 records/file.
