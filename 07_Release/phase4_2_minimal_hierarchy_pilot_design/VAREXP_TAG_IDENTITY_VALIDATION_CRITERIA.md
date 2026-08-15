# VAREXP Tag Identity Validation Criteria

| Field | Value |
|---|---|
| Status | Proposed |
| Date | 2026-08-14 |

## Exact candidate combinations

1. Tagname
2. COL_003 + Tagname
3. COL_003 + COL_004 + Tagname
4. COL_003 + COL_004 + COL_005 + Tagname

Use case-sensitive, length-delimited original values without trimming, normalization or aliasing. For every level calculate total eligible rows, null-containing rows, distinct tuples, unique rows, unique rate, duplicate groups and largest duplicate group. Repeat globally and per SourceFileId.

Also calculate each hierarchy field's null/empty rate; candidate tuples with conflicting Description, Class or Domain; cross-source reuse; candidate serialization/hash errors; and results by TAG_RECORD_CANDIDATE, NON_TAG_RECORD_CANDIDATE and AMBIGUOUS. Nothing may be silently discarded.

## Shortest stable combination

A structural candidate requires 100% uniqueness among eligible TAG_RECORD_CANDIDATE rows globally and per source, zero Description/Class/Domain conflicts, deterministic reproduction from original values/provenance, no sensitive event, and explicit accounting for null and excluded record types. Select the shortest combination meeting every condition. Otherwise remain UNRESOLVED.

| State | Rule |
|---|---|
| UNRESOLVED | hierarchy absent, conflict exists or no stable combination |
| CANDIDATE | deterministic tuple passes security and shape checks |
| STRUCTURALLY_VALIDATED | shortest combination passes all criteria within the bounded five-file pilot |
| CONFIRMED | prohibited; requires official evidence or separately governed onsite validation |

Uniqueness alone never proves an official PCVue Tag ID. Description is never an identifier.
