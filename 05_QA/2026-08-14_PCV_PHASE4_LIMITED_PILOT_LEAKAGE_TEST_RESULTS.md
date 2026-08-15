# Sensitive and Excluded Field Leakage Test Results

All searches were performed across every entry of each generated result ZIP.

| Sentinel/category | Occurrences | Result |
|---|---:|---|
| Excluded positional field value | 0 | PASS |
| Raw-row-only sentinel | 0 | PASS |
| Production-config 21st record | 0 | PASS |
| Global 101st row | 0 | PASS |
| Credential/secret raw value | 0 | PASS |
| 256-KiB over-boundary raw value | 0 | PASS |
| Unapproved CSV sentinel | 0 | PASS |
| DAT/XLSX/XML sentinel | 0 | PASS |
| Full Production path | 0 by output contract | PASS |

The sensitive fixture stopped with SENSITIVE_REVIEW_REQUIRED and stored only the status and audit counts. No matched text or surrounding field was serialized.

Approved output columns were exactly SourceFileId, SchemaVariant, SchemaHash, SourceRecordIndex, and paired OriginalHeader/Value columns for the 17 positional allowlist entries.
