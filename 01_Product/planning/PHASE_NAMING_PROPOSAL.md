# Phase Naming Normalization Proposal

| Field | Value |
|---|---|
| Status | Review |
| Version | 0.1.0 |
| Date | 2026-08-06 |
| Backlog | `ARC-003` |
| Owner | Product owner |
| Authority | [Product Charter](../../00_Governance/03_PRODUCT_CHARTER.md) and [Master Project Charter](../../MASTER_PROJECT_CHARTER.md) |

## Decision Required

Approve one authoritative lifecycle vocabulary for operational planning. The recommended structure makes **Phase 2 — Platform Engineering** the current phase and moves **Core Engineering Tools** to Phase 3.

## Conflict

The adopted Master Charter does not assign operational phase numbers. Two operational labels currently compete:

- the existing Roadmap uses `Phase 2 — Core Engineering Tools`; and
- the CTO Phase 2 kickoff uses `Phase 2 — Platform Engineering`.

Leaving both active would make status, Backlog sequencing, QA evidence, and approval gates ambiguous.

## Recommended Authoritative Structure

| Phase | Name | Outcome |
|---|---|---|
| Phase 1 | Constitutional and Governance Foundation | Master Charter v1.0, frozen Governance Architecture, authority hierarchy, Standards, records, and QA system are established. |
| Phase 2 | Platform Engineering | Platform Architecture v1.0, ADRs, non-functional baseline, design-system foundation, WordPress module foundation, and representative framework slice are approved and validated. |
| Phase 3 | Core Engineering Tools | Engineers can use governed Calculator, Reference, Knowledge, and Asset foundations through the shared Platform. |
| Phase 4 | Troubleshooting and Engineering Knowledge | Trouble Guide, equipment relationships, vendor knowledge, and reviewed knowledge workflows become usable. |
| Phase 5 | Operational and Energy Intelligence | Approved read-oriented SCADA, alarms, energy, carbon, reporting, and operational context are introduced through isolated boundaries. |
| Phase 6 | Governed AI Assistance | AI assistance retrieves approved knowledge with citations, permissions, evaluation, monitoring, and accountable human boundaries. |

## Rationale

Platform Architecture, quality budgets, WordPress boundaries, responsive foundations, and shared services must exist before feature frameworks can be implemented responsibly. Keeping Core Engineering Tools as Phase 2 would either hide this prerequisite work or encourage feature-first architecture.

The normalized sequence also keeps live SCADA and AI work later than their architectural boundaries and validation requirements.

## Operational Document Impact

Upon approval:

- `ROADMAP.md` becomes the authoritative operational phase sequence above;
- `AI_STATUS.md` identifies Phase 2 Platform Engineering as current;
- Backlog items retain their identifiers and are sequenced by dependencies rather than renumbered;
- historical Changelog and QA records remain unchanged; and
- Product Charter and Master Charter remain unchanged.

## Compatibility

Existing references to “Sprint 1 — Foundation” describe an earlier bounded work horizon and remain historically valid. They do not override the normalized lifecycle phases.

Existing references to the former `Phase 2 — Core Engineering Tools` shall be interpreted as the now-proposed Phase 3 outcome after this decision becomes Active.

## Risks

| Risk | Treatment |
|---|---|
| Stakeholders assume Phase 2 already includes Dashboard implementation | State that Phase 2 first completes architecture decisions and foundation gates; Dashboard code remains separately authorized. |
| Historical records appear inconsistent | Preserve them as dated evidence and add no retroactive rewrites. |
| Phase renaming becomes a Governance structure change | Limit changes to operational planning documents; no Governance authority or directory responsibility changes. |
| New phases imply fixed dates | Retain the Roadmap rule that phases express sequencing, not calendar commitments. |

## Acceptance Criteria

- exactly one active phase taxonomy exists;
- Phase 2 is named Platform Engineering;
- Core Engineering Tools remains a distinct later outcome;
- historical records are preserved;
- no Master Charter, Product Charter, or frozen Governance Architecture change occurs; and
- AI Status, Roadmap, Backlog, and Changelog remain consistent after approval.

## Recommendation

**Approve the six-phase structure and make `ROADMAP.md` its authoritative operational representation.**
