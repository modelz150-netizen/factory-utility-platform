# VAREXP Tag Identity Model

| Field | Value |
|---|---|
| Status | Proposed — unconfirmed |
| Date | 2026-08-14 |

- Preserve numeric VAREXP_COL_002 Tagname exactly; do not renumber or normalize it.
- Description/DescriptionAlt are attributes, never IDs.
- Use positional IDs as keys and OriginalHeader only as provenance.
- Never alias n1 and n1(Factory).
- Keep candidate hierarchical ID distinct from original Tagname.

The candidate tuple is (SourceFileId, SchemaHash, approved hierarchy positional values, VAREXP_COL_002). Only later-approved fields may participate. If a compact key is needed, CANDIDATE_HIERARCHICAL_TAG_ID is a versioned SHA-256 of length-prefixed original UTF-8 tuple components. It is a correlation candidate, not an official PCVue name.

| State | Meaning |
|---|---|
| UNRESOLVED | Current evidence cannot form a stable identity |
| CANDIDATE | A deterministic tuple exists under an approved bounded pilot |
| STRUCTURALLY_VALIDATED | The tuple is collision-free/stable within approved scope |
| CONFIRMED | Authoritative documentation or accountable human validation confirms meaning |

The current 40 rows remain UNRESOLVED: the approved evidence contains numeric leaf Tagname values but no approved hierarchy values.
