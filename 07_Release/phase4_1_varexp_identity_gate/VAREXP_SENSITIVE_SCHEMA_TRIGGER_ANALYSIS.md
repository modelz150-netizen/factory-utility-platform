# VAREXP Sensitive Schema Trigger Analysis

| Field | Value |
|---|---|
| Status | Review |
| Date | 2026-08-14 |
| Scope | Existing RC5 header/schema and Phase 4 Pilot evidence only |
| Production access | Not performed |

## Finding

VAREXP_01, VAREXP_03, and VAREXP_04 stopped on logical record 1, the VERSION metadata preamble. Their verified 262-column schemas are at record 2. The RC1 pilot applies SensitivePattern before Test-Version/Test-Schema, and its literal-backslash alternative matches the local Windows source-path metadata in preamble field 5. No raw path or value is reproduced here.

| SourceFileId | Schema record | Trigger record | Rule | Classification |
|---|---:|---:|---|---|
| VAREXP_01 | 2 | 1 | WINDOWS_PATH_BACKSLASH in VERSION metadata field 5 | SCHEMA_NAME_FALSE_POSITIVE |
| VAREXP_03 | 2 | 1 | WINDOWS_PATH_BACKSLASH in VERSION metadata field 5 | SCHEMA_NAME_FALSE_POSITIVE |
| VAREXP_04 | 2 | 1 | WINDOWS_PATH_BACKSLASH in VERSION metadata field 5 | SCHEMA_NAME_FALSE_POSITIVE |

The requested classification label is retained; technically these are schema-discovery-layer metadata false positives, not matches on a schema field name.

## Evidence and root cause

- VAREXP_02/05 have schema at record 1 and passed discovery.
- The known five 262-position header sets contain no value matching the credential, URL, IPv4, or path-value alternatives.
- OPCUA_* header names do not match the endpoint rule because they contain neither an endpoint colon nor slash.
- The implementation scans an untyped raw record with a value-oriented detector before distinguishing VERSION metadata, schema names, and data values.

This analysis does not approve data-row access or a Collector change.
