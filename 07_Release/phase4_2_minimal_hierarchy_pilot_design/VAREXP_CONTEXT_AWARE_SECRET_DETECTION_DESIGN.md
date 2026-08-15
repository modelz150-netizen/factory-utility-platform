# VAREXP Context-Aware Secret Detection Design

| Field | Value |
|---|---|
| Status | Proposed for user approval |
| Date | 2026-08-14 |
| Scope | Design only; no Collector or Production execution |

## Mandatory processing order

1. Read one bounded logical record into volatile memory.
2. Parse CSV syntax without logging raw text.
3. Classify it as VERSION_METADATA, SCHEMA_HEADER, DATA_RECORD, or UNKNOWN.
4. Apply only the matching context policy.
5. Store audit categories and positions, never a rejected raw value.
6. Discard the raw buffer after the decision.

| Context | Structural gate | Local Windows path | Credential policy | Allowed result |
|---|---|---|---|---|
| VERSION_METADATA | strict VERSION signature within existing 3-record/64 KiB limit | backslash alone is metadata, not secret; raw path discarded | password/passwd/pwd/credential/secret/token/private key/API key/certificate/connection string remain fail-closed; URL, UNC/device, endpoint and IP remain review-required | type, record index, bytes and category only |
| SCHEMA_HEADER | exact 262 fields, required signatures and approved schema family/hash | path syntax unexpected and review-required | header semantics recorded separately; header never authorizes a data value | positional ID, OriginalHeader and schema hash |
| DATA_RECORD | schema/hash first; exactly 262 fields | path strings remain sensitive values; none are approved | all existing credential/token/key/certificate controls retained | only 20 approved fields |
| UNKNOWN | none | no exception | fail closed | classification and stop reason only |

SchemaNameDetector, MetadataValueDetector, DataValueDetector and OutputLeakageDetector are separate. The data detector scans all 262 in-memory values before projection. A match stores source ID, context, record index, rule ID and positional ID only.

No actual-value rule is weakened. The sole contextual distinction is that a backslash inside a structurally valid, discarded VERSION source-path field is not itself a secret. No implementation or execution is authorized.
