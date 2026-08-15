# PvTrend Schema Rule

## Scope

This rule applies only to the exact approved PvTrend CSV in the 11-file allowlist. It does not authorize a general CSV rule or access to a second logical record.

## Required signature

All conditions must be satisfied:

- Approved relative path under the approved local fixed-drive root.
- No UNC, device, network/mapped path, or reparse point.
- `.csv` extension.
- UTF-8 BOM.
- Comma delimiter.
- Valid CSV syntax in the first logical record.
- Exactly 6 columns.
- Only column 1 is empty.
- Columns 2 through 6 are non-empty and non-duplicate.
- No trailing empty column.
- Columns 2 through 6 represent the same series and the observed Minimum, Maximum, Weighted average, Minimum timestamp, and Maximum timestamp field family.

The original empty first header remains empty in evidence. `TIME_INDEX` may be used only as an internal role label; it must not be represented as a confirmed source header or proven data type.

## Read boundary

- Read only the first logical record.
- Maximum bytes read: 64 KiB (65,536 bytes).
- Never access the second logical record.
- Stop immediately after schema evaluation.
- Never store or output a data row.

## Outcomes

- Exact signature and no sensitive pattern: `APPROVED_STRUCTURE`.
- Empty header outside column 1, column-count/encoding/delimiter/suffix mismatch, or ambiguity: `STRUCTURE_REVIEW_REQUIRED`.
- Invalid CSV syntax: `HEADER_PARSE_FAILED`.
- Credential/secret pattern: immediately stop and return `SENSITIVE_REVIEW_REQUIRED` without storing matching text.

## Production impact

The rule stays within RC4's first-record boundary and adds no data-row access. It is a design only and does not authorize RC5 implementation or Production execution.
