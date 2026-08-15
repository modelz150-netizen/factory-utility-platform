# RC5 Read Boundary and Security Policy

## Gate and authorization

This policy is a pre-implementation design. RC5 must not be implemented or executed in Production until this documentation Gate passes and the subsequent implementation and Production execution are separately approved.

## Approved content scope

Content access is restricted to the exact 11 approved CSV paths: VAREXP 5, HISTO 5, and PvTrend CSV 1. Wildcard or recursive discovery must not expand the content-access set.

Content access is prohibited for:

- Any file outside the approved 11 CSV files.
- DAT and other PCVue native files.
- XLSX files.
- XML files.
- Extensionless native files.

Network, DB, PLC, and OPC access is prohibited. Production originals must not be created, changed, renamed, deleted, or have timestamps altered. PCVue and service/process control are prohibited. Automatic privilege elevation is prohibited.

## Domain read boundaries

| Domain | Maximum logical records | Maximum bytes | Second-record access | Required stop |
|---|---:|---:|---|---|
| VAREXP | 3 per file | 64 KiB per file | Only while performing limited schema discovery | Immediately when schema is found or either limit is reached |
| HISTO | No additional record beyond RC4 evidence | 0 additional bytes | Prohibited | `MANUAL_FORMAT_REVIEW_REQUIRED` |
| PvTrend CSV | 1 per file | 64 KiB per file | Prohibited | Immediately after first-record schema evaluation |

The record and byte boundaries are simultaneous ceilings; the first reached terminates content reading. A logical record is one complete CSV record under quoting rules, not a physical line.

## Path and identity controls

Before opening content, verify the exact normalized allowlisted relative path, approved root, local fixed drive, `.csv` extension, file identity, and absence of UNC/device/network/mapped paths and reparse points. Validate that the file was not replaced or changed during reading. Any failure is fail-closed and does not permit fallback discovery.

## Data minimization

- Use a read-only bounded sequential stream.
- Stop reading immediately at the applicable boundary.
- Store only approved metadata, schema-header fields, structural counts/indexes, bytes and logical records read, status, and stop reason.
- Never store or output raw data rows.
- Never store or output a raw non-schema record or any of its fields.
- Never emit previews, escaped content, base64, hex, exception context, stack traces containing content, or debug buffers.
- Reduce non-schema records in memory to signature booleans/counts and discard them immediately.
- The result serializer must use a fixed allowlist and must not serialize arbitrary parser or exception objects.

Result manifests must state `DATA_ROWS_STORED=0` and `RAW_NON_SCHEMA_ROWS_STORED=0`.

## Credential and secret response

If a credential or secret pattern is detected, terminate reading immediately, discard the raw buffer, and return `SENSITIVE_REVIEW_REQUIRED`. Record only the pattern category and status. Never store the matched text or its surrounding content.

## Integrity and non-leakage verification

Any later RC5 implementation must undergo Windows PowerShell 5.1 nonProduction validation before a separate Production approval request. Required checks include static/security validation, exact allowlist enforcement, launcher-to-ZIP E2E, logical-record and byte-boundary fixtures, schema-stop behavior, canary data-row and secret non-leakage searches, absence of raw CSV/native/XLSX/XML content, internal hashes, external ZIP SHA-256, and ZIP re-open verification.

## Production impact assessment

These documents cause no Production access or change. A separately approved future RC5 could read at most three logical records and 64 KiB from each approved VAREXP file, whichever limit is reached first. HISTO receives no additional content read. PvTrend remains limited to its first logical record. No writes, external connections, or process/service control are permitted.
