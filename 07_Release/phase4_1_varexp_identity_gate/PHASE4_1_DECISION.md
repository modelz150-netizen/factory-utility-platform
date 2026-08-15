# Phase 4.1 Decision

| Field | Value |
|---|---|
| Status | Gate complete |
| Date | 2026-08-14 |
| Final decision | **MANUAL_HIERARCHY_REVIEW_REQUIRED** |
| Production access/execution | None |
| Collector change | None |

## Decision

- VAREXP_01/03/04 are SCHEMA_NAME_FALSE_POSITIVE in the requested vocabulary: the literal-backslash rule hit discarded VERSION path metadata before record typing, not a credential or schema field name.
- Layer separation is feasible without weakening strict data-value protection.
- Positions 3-9 are stable QUALIFIER_VARIANT columns, but no official PCVue 16.2 evidence proves hierarchy semantics. n1 and n1(Factory) remain distinct.
- Minimum review order is 003-005 plus Tagname; 006 only if needed, 007 only on collision evidence, and 008-009 excluded initially.
- Existing aggregate evidence supports 38 TAG_RECORD_CANDIDATE and 2 NON_TAG_RECORD_CANDIDATE. Nothing is deleted; all remain UNRESOLVED.

The Gate is not ready because current evidence cannot show that 003-005 contain only hierarchy names, are sufficiently unique, or are free of address-like OT identifiers. Human approval of fields, sensitive rules, a bounded read limit, and collision criteria is required before implementation.

No Production reread/recollection, 39-file expansion, data-row access, Collector change, AI ingestion, HISTO, PLC/HMI mapping, network, database, PLC, or OPC access was performed or authorized.
