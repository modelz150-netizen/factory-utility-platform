# Phase 4.2 Field Leakage Results

| Check | Observed | Result |
|---|---:|---|
| Approved positional fields | 20 | PASS |
| COL_006–009 values | 0 | PASS |
| Excluded-field sentinel | 0 | PASS |
| Raw-row sentinel | 0 | PASS |
| Credential/secret raw sentinel | 0 | PASS |
| Full Project Files path | 0 | PASS |
| Raw 262-field rows | 0 | PASS |
| CONFIRMED identity state | 0 | PASS |
| Other 34 VAREXP access | 0 | PASS |
| HISTO/DAT/XLSX/XML access | 0 | PASS |

TAG_DATA contains four provenance columns plus header/value pairs for exactly 20 approved positional fields. Candidate identity files contain hashes and metrics, not raw hierarchy tuples.
