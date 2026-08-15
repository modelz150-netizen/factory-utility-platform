# VAREXP Schema Family Decision

## Evidence summary

| Evidence | Result |
|---|---|
| Stable positions | 262/262 across five files |
| Identical empty positions | 85/85 across five files |
| Exact common non-empty headers | 151 positions |
| Case-only variants | 19 positions |
| Qualifier variants | 7 positions, columns 3–9 |
| Semantic conflicts | 0 observed |
| Unknown variants | 0 observed |
| Official PCVue 16.2 positional specification | Not available |

## Family assessment

The files share a stable 262-position frame and identical empty-position pattern. Nineteen variations can be represented as case aliases without modifying originals. Seven hierarchy headers use short versus parenthetically annotated labels; their shared position is stable, but their semantic equivalence is not officially established and automatic merging is prohibited.

A SINGLE_SCHEMA_WITH_ALIASES decision would require treating all 26 differences as safe aliases, which is not supported. INCOMPATIBLE_SCHEMA_FAMILIES is also not supported because there is no positional displacement, empty-pattern divergence, malformed schema, or observed semantic contradiction.

**Schema family decision: MULTIPLE_COMPATIBLE_SCHEMA_VARIANTS**

Compatibility here means the five schemas can coexist under a common positional contract while preserving source-specific headers. It does not mean the seven qualifier variants are semantically interchangeable.

## Data acquisition recommendation

**Final recommendation: MANUAL_SCHEMA_REVIEW_REQUIRED**

VAREXP is not yet ready for general Tag data-row acquisition. Manual review must resolve or explicitly exclude columns 3–9 and approve the positional contract and allowed field subset. If a later limited acquisition is approved, it must follow the original-schema and positional-ID safeguards in the contract.

## Unchanged domain status

- PvTrend: APPROVED_STRUCTURE. No data-row collector implemented.
- HISTO: MANUAL_FORMAT_REVIEW_REQUIRED. No parser or additional read implemented.

## Activity boundary

Production was not accessed or rerun. No additional content or data row was read. RC6 and data-row collectors were not implemented.
