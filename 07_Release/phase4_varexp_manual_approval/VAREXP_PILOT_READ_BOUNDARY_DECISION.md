# VAREXP Pilot Read Boundary Decision

## Decision

The earlier 5 files × 100 data records × 1 MiB design is larger than necessary for the first Production validity check. The initial Pilot is reduced; no boundary is expanded.

## Final proposed boundary

| Boundary | Previous proposal | Final proposal |
|---|---:|---:|
| Approved source files | 5 | 5 |
| Data logical records per file | 100 | **20** |
| Data-row bytes per file | 1 MiB | **256 KiB (262,144 bytes)** |
| Maximum emitted rows | 500 | **100** |
| Value fields per row | 42 | **17** |

All ceilings apply simultaneously and reading stops at the first reached limit. The five source files are retained because they represent both schema-at-record-1 and VERSION-preamble/schema-at-record-2 families and provide cross-file validity evidence. Twenty data records per file are sufficient to test 262-field alignment, approved-field presence, null/empty behavior, source provenance, and exclusion controls without collecting a broad Tag inventory.

## Schema and row rules

- Revalidate the source-specific 262-column schema before data-row access.
- Use VAREXP_COL_001 through VAREXP_COL_262 as internal IDs.
- A data record must contain exactly 262 fields. Any mismatch stops that source file.
- Emit only the 17 final allowlist fields.
- Eight METADATA_ONLY candidates are not emitted as row values.
- Seventeen EXCLUDE decisions and every field outside the original 42 are not emitted.
- QUALIFIER_VARIANT and RESERVED_CANDIDATE_UNCONFIRMED values remain excluded.
- Raw rows, previews, rejected values, and parser exception context are prohibited.

## Stop conditions

Stop the current file on schema mismatch, malformed CSV, 262-field mismatch, file identity change, record/byte boundary, unexpected encoding/delimiter, credential/secret pattern, output-policy violation, or any unhandled error. Failures do not expand scope to another file.

## Authorization state

This decision is approval material only. It does not authorize Collector implementation or Production execution.

**Recommendation: READY_FOR_USER_APPROVAL**
