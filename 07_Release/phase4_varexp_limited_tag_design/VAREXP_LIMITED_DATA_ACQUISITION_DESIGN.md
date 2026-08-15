# VAREXP Limited Data Acquisition Design

## Status

This is a design Gate only. It does not authorize Production data-row access or Collector implementation. The Phase 3 schema-family decision is MULTIPLE_COMPATIBLE_SCHEMA_VARIANTS.

## Acquisition model

- Use VAREXP_COL_001 through VAREXP_COL_262 as immutable internal column IDs.
- Bind every row to SourceFile, source-specific schema hash, logical record index, and OriginalHeader provenance.
- Never use a header string as a storage key.
- Store normalized aliases only as separate metadata.
- Never overwrite or merge source-specific OriginalHeader values.

## Column handling

| Classification | Count | Pilot behavior |
|---|---:|---|
| APPROVED_FOR_DATA_ACQUISITION | 42 | May be emitted only after a separate Production execution approval |
| METADATA_ONLY | 39 | Schema/provenance only; do not emit row values |
| EXCLUDED_SCHEMA_UNCERTAIN | 92 | Parse position only to maintain CSV alignment; discard value immediately |
| EXCLUDED_SENSITIVE | 88 | Do not emit; discard immediately and apply sensitive-stop policy |
| NOT_REQUIRED_FOR_UTILITY_AI | 1 | Do not emit |

The 92 schema-uncertain positions comprise 7 QUALIFIER_VARIANT positions and 85 RESERVED_CANDIDATE_UNCONFIRMED positions.

## Proposed limited read boundary

A future separately approved Pilot should use both ceilings and stop at the first reached:

- Maximum 100 data logical records per approved file.
- Maximum 1 MiB (1,048,576 bytes) of data-row content per approved file, excluding the already approved schema-discovery read.
- Maximum five approved files; no discovery or expansion to the other 34 VAREXP candidates.
- Stop immediately on schema mismatch, file change, malformed CSV, boundary exhaustion, or sensitive-pattern detection.

These values are proposed limits, not implementation authorization. A later implementation Gate must explicitly approve them.

## Row processing

1. Revalidate the source-specific schema using the approved RC5 bounded method.
2. Confirm exactly 262 fields for every candidate data record; otherwise stop the file.
3. Bind values by positional ID.
4. Emit only the 42 approved fields.
5. Do not serialize excluded, metadata-only, uncertain, sensitive, or not-required values.
6. Never output a raw row, preview, exception context, debug buffer, or rejected value.
7. Record per file: bytes read, logical records read, emitted rows, rejected rows, stop reason, schema hash, and source identity.

## Output minimization

Proposed outputs may contain approved values plus source-relative path, file SHA-256, schema SHA-256, positional IDs, OriginalHeader provenance, and audit counts. Raw CSV files and full records are prohibited. Results remain FIELD_USE_NOT_APPROVED until a downstream privacy/OT-security review.

## Gate decision

The positional and field design is feasible, but actual values have never been reviewed. Sensitive communication fields are excluded, and columns 3–9 remain unresolved. A human must approve the 42-field allowlist and proposed row/byte limits before implementation.

**Final Gate: MANUAL_FIELD_REVIEW_REQUIRED**
