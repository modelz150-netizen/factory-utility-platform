# VAREXP Minimal Hierarchy Pilot Design

| Field | Value |
|---|---|
| Status | Proposed for user approval |
| Date | 2026-08-14 |
| Purpose | Test whether COL_003–005 disambiguate numeric/duplicate Tagname values |

## Fixed scope

- Same five verified VAREXP sources only.
- Existing 17 fields plus COL_003, COL_004 and COL_005; maximum 20 fields.
- Maximum 20 data logical records or 256 KiB per file, whichever occurs first.
- Maximum 100 emitted records globally.
- Other 34 VAREXP, HISTO, DAT, XLSX, XML, network, DB, PLC, OPC and services excluded.
- No raw 262-field row, rejected value, full path or unapproved field stored.

The limits equal the prior pilot and do not enlarge source, record, byte or row scope. A future implementation may permit a smaller operator-approved run but never exceed these caps.

## Processing requirements

1. Validate approved source ID/path and fixed local non-reparse root.
2. Apply context-aware VERSION/schema/data handling.
3. Verify source-specific 262-column schema family and hash before data access.
4. Scan all in-memory fields for secrets, then project only the 20 allowlisted positions.
5. Preserve SourceFileId, SchemaVariant, SchemaHash, SourceRecordIndex, PositionalId, OriginalHeader and original value.
6. Never normalize, concatenate, alias or overwrite hierarchy values or Tagname in acquisition output.
7. Put derived candidate combinations in a separate analysis result.

Audit must expose logical records, bytes, emitted rows, stop reason, schema index/hash, sensitive rule/position, RAW_VALUE_STORED=FALSE and UNAPPROVED_VALUES_STORED=0.

This design does not authorize implementation, nonProduction execution or Production execution.
