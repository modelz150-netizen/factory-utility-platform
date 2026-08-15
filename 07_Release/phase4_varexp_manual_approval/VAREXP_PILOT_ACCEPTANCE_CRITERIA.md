# VAREXP Pilot Acceptance Criteria

A future implementation and Production run pass only when every mandatory criterion below passes.

## Mandatory security and integrity criteria

| Criterion | Pass condition |
|---|---|
| 262-field record validation | Every accepted data logical record has exactly 262 fields |
| Approved-field-only output | Every emitted value is keyed by one of the 17 allowlisted positional IDs |
| Excluded-field output | 0 values |
| METADATA_ONLY row-value output | 0 values |
| Raw row output | 0 rows and 0 previews/encoded copies |
| Credential/secret raw value | 0 occurrences in all result entries and logs |
| Original changes | 0; pre/post file identity, size, timestamp and hash unchanged |
| Read-boundary violations | 0; no file exceeds 20 data records or 262,144 data bytes |
| Source allowlist violations | 0; only the five approved VAREXP paths opened for data rows |
| Native/HISTO/PvTrend/other content access | 0 under this Pilot |
| Internal/external SHA-256 | All result hashes and ZIP hash pass |

## Data validity criteria

| Criterion | Pass condition |
|---|---|
| Tagname identification | VAREXP_COL_002 is non-empty for 100% of emitted rows and unique-key construction succeeds with SourceFile |
| Class/Nature/Domain | Presence rate reported separately; each reaches at least 95% or Pilot remains REVIEW_REQUIRED |
| Description coverage | At least one of VAREXP_COL_016 or VAREXP_COL_017 is present in at least 80% of emitted rows, otherwise REVIEW_REQUIRED |
| Unit coverage | Presence rate is reported; for rows classified as measured/analog, at least 90% have VAREXP_COL_066 or Pilot remains REVIEW_REQUIRED |
| Alarm/historian fields | Presence/null distribution reported without interpreting excluded thresholds or addresses |
| Provenance | 100% of emitted rows retain SourceFile, source-relative path, file SHA-256, schema SHA-256, logical record index, positional ID, and source-specific OriginalHeader |

## Result audit fields

Per file, record LOGICAL_RECORDS_READ, DATA_RECORDS_ACCEPTED, DATA_RECORDS_REJECTED, BYTES_READ, STOP_REASON, SCHEMA_RECORD_INDEX, source/schema hashes, and emitted-field count. The final manifest must state RAW_ROWS_STORED=0, EXCLUDED_FIELD_VALUES_STORED=0, and CREDENTIAL_SECRET_RAW_VALUES_STORED=0.

## Overall decision

Any mandatory security/integrity failure is FAIL. Data coverage below the stated thresholds is REVIEW_REQUIRED, not permission to expand the read boundary.
