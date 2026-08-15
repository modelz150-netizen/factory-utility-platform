# VAREXP Positional Schema Contract

## Contract identity

The internal schema contains exactly 262 stable positional IDs: VAREXP_COL_001 through VAREXP_COL_262. Position, not header text, is the primary identity.

Each source-specific binding contains:

- SourceFile
- PositionalColumnId
- Position
- OriginalHeader
- NormalizedHeader
- VariantGroup
- Status
- CandidateCanonicalName
- CanonicalizationConfidence or review requirement

## Invariants

- Preserve all 262 positions, including empty headers.
- Preserve each source file’s OriginalHeader exactly.
- Store aliases and normalized names only as separate metadata.
- Never overwrite one source’s header with another source’s spelling.
- Never shift positions to remove empty fields.
- Never infer semantic equivalence from matching position alone.
- Never interpret Unknown or conflict fields automatically.

## Status rules

| Status | Meaning | Automated semantic use |
|---|---|---|
| KNOWN_COMMON_HEADER | Exact original header is common to all five files | Position binding allowed; semantics still not vendor-certified |
| CASE_ONLY_VARIANT | Difference is casing only | Alias metadata allowed; originals required |
| QUALIFIER_VARIANT | Parenthetical annotation differs | Manual schema review required |
| RESERVED_CANDIDATE_UNCONFIRMED | All five headers empty at this position | No semantic use |
| SEMANTIC_CONFLICT / UNKNOWN_VARIANT | Meaning conflicts or is unresolved | No automated use |

## Future data-row collector prerequisites

Any separately approved collector must store the original schema for each source, retain all positional IDs, preserve original headers, keep aliases as metadata, prohibit cross-file header overwrites, and reject automatic interpretation of unknown/conflicting fields. It must additionally receive a new read-boundary and security approval.

## Scope

This contract was derived only from RC5 schema outputs. It does not authorize Production access, data-row reads, RC6 implementation, or changes to HISTO/PvTrend handling.
