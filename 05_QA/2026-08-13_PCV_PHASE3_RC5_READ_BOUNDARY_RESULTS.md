# RC5 Read Boundary Verification Results

## Main scenario

| Fixture | Records | Bytes | Stop reason | Schema index | Expected status | Result |
|---|---:|---:|---|---:|---|---|
| VAREXP first-record schema | 1 | 2506 | SCHEMA_FOUND | 1 | APPROVED_STRUCTURE | PASS |
| VAREXP VERSION then schema with empty/duplicate | 2 | 2553 | SCHEMA_FOUND | 2 | STRUCTURE_REVIEW_REQUIRED | PASS |
| VAREXP no schema in three records | 3 | 33 | RECORD_LIMIT_REACHED | 0 | REVIEW_REQUIRED | PASS |
| VAREXP 64 KiB boundary | 0 | 65536 | BYTE_LIMIT_REACHED | 0 | REVIEW_REQUIRED | PASS |
| VAREXP malformed quote | 1 | 38 | MALFORMED_CSV_UNCLOSED_QUOTE | 0 | ERROR | PASS |
| HISTO five approved files | 0 each | 0 each | HISTO_CONTENT_NOT_ACCESSED | 0 | MANUAL_FORMAT_REVIEW_REQUIRED | PASS |
| PvTrend approved schema | 1 | 189 | SCHEMA_FOUND | 1 | APPROVED_STRUCTURE | PASS |

Additional scenarios:

- Credential sentinel: SENSITIVE_REVIEW_REQUIRED at record 1; raw secret output count 0.
- PvTrend empty column outside column 1: REVIEW_REQUIRED; second record not accessed.
- All VAREXP reads stayed at or below 3 logical records and 65,536 bytes.
- All PvTrend reads stopped after the first logical record.
- HISTO content-discovery audit remained 0 records and 0 bytes.
- Fixture file hashes before and after execution were identical.
