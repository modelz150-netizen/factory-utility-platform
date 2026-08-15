# VAREXP Canonicalization Policy

## Purpose

This policy permits comparison aliases without changing any Production-derived original header. It is metadata policy only and does not authorize data-row acquisition.

## Normalization layers

1. OriginalHeader is immutable evidence and is always retained per source file and position.
2. NormalizedHeader may trim surrounding whitespace, collapse repeated whitespace, and apply invariant uppercase for comparison.
3. CandidateCanonicalName is a separate metadata field. It never overwrites OriginalHeader.
4. PositionalColumnId is the authoritative internal identity while official PCVue field evidence is unavailable.

## Conflict classifications

- CASE_ONLY_VARIANT: all five values are equal under invariant case folding. Nineteen positions meet this condition. A normalized alias may be generated with HIGH confidence, but all originals remain attached to their source files.
- QUALIFIER_VARIANT: values share a base token after removing a parenthetical qualifier, but the qualifier may carry meaning. Seven positions, columns 3–9, meet this condition. They must not be auto-merged.
- SEMANTIC_CONFLICT: non-empty names indicate different meanings at the same position. None observed.
- UNKNOWN_VARIANT: insufficient pattern for another class. None observed.

## Automatic merge rule

Automatic alias grouping is allowed only for CASE_ONLY_VARIANT, and only as metadata. It must not rewrite a header, combine source values, or imply vendor-confirmed equivalence. QUALIFIER_VARIANT, SEMANTIC_CONFLICT, and UNKNOWN_VARIANT require manual review.

## Empty headers

The 85 identical empty positions remain RESERVED_CANDIDATE_UNCONFIRMED. They retain positional IDs and must not be described as reserved or unused without official evidence.

## Prohibited actions

- Replacing OriginalHeader with a canonical name.
- Using a header string alone as a column ID.
- Automatically interpreting qualifier differences.
- Mapping unknown/conflicting fields into a semantic Tag model.
- Implementing or running a data-row collector under this Gate.
