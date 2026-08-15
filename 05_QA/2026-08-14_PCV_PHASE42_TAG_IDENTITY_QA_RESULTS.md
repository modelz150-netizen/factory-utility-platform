# Phase 4.2 Tag Identity Calculation QA

| Combination | Eligible/Total | Unique rate | Duplicate rows | Conflicts | State |
|---|---:|---:|---:|---:|---|
| Tagname | 100/100 | 0% | 100 | 10 | CANDIDATE |
| COL_003 + Tagname | 99/100 | 1.0101% | 98 | 49 | CANDIDATE |
| COL_003–004 + Tagname | 98/100 | 2.0408% | 96 | 48 | CANDIDATE |
| COL_003–005 + Tagname | 97/100 | 100% | 0 | 0 | STRUCTURALLY_VALIDATED |

This is fixture evidence, not Production identity evidence. Candidate hashes use case-sensitive, length-delimited original values. No normalization, aliasing, Description-as-ID, or CONFIRMED promotion occurs.
