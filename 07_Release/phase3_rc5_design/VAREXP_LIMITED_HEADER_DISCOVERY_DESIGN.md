# VAREXP Limited Header Discovery Design

## Gate status

This document is a pre-implementation design. It does not authorize RC5 implementation or Production execution.

## Fixed discovery boundary

- Maximum logical records read per approved VAREXP CSV: **3**.
- Maximum content bytes read per approved VAREXP CSV: **64 KiB (65,536 bytes)**.
- Stop immediately when either limit is reached.
- A logical record is one complete CSV record, including quoted embedded newlines; it is not a physical line.
- Stop all further reads immediately when the schema header is found.

## VERSION preamble signature

Treat the first logical record as a VERSION preamble only when CSV syntax is valid, the first non-empty trimmed field equals `VERSION` case-insensitively, an independent `VAR` format field is present, and the record does not also satisfy the schema signature. Path, date, time, and other preamble field values are not stored or output.

An incomplete or conflicting signature is `AMBIGUOUS_FIRST_RECORD` and results in `REVIEW_REQUIRED`.

## 262-column schema signature

A schema candidate must satisfy all of the following:

- Valid comma-delimited CSV syntax.
- Exactly 262 columns.
- Independent column names `Class` and `Tagname`.
- At least two of `Domain`, `Nature`, and `Source`.
- At least one field family associated with Alarm, OPC, BACnet, IEC104, IEC61850, SNMP, or OPCUA.
- First non-empty field is not `VERSION`.

Comparison may be case-insensitive with surrounding whitespace removed. Empty and duplicate header columns are recorded as counts and indexes; they do not cause a non-schema record to be promoted to a schema.

## Read and retention procedure

1. Verify the exact approved relative path, local fixed drive, approved root, extension, file identity, and absence of UNC/device/network/mapped paths and reparse points.
2. Open a read-only sequential stream.
3. Parse within the fixed record and byte limits.
4. Evaluate each logical record only as a preamble or schema candidate.
5. On confirmed schema, retain the approved schema-header fields and structure statistics and close the stream immediately.
6. If no schema is found within the boundary, close the stream and return `REVIEW_REQUIRED`.

Non-schema record text, fields, data rows, previews, escaped text, base64, hex, exception context, and debug buffers must never be written to results or logs. Non-schema content is reduced in memory to booleans and counts needed for the signature decision and then discarded.

## Sensitive-content stop

If a credential or secret pattern is detected, close the stream immediately and return `SENSITIVE_REVIEW_REQUIRED`. Store only the pattern category and status; never store the matching text or surrounding content.

## Outcomes

- Schema found: stop immediately and apply the existing empty/duplicate-header review rules.
- No schema within 3 logical records or 64 KiB: `REVIEW_REQUIRED`.
- Ambiguous signature: `REVIEW_REQUIRED`.
- Credential/secret pattern: `SENSITIVE_REVIEW_REQUIRED`.
- Path, encoding, delimiter, parsing, identity, or boundary error: fail closed.
