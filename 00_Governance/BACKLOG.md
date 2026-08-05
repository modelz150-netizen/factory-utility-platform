# Product Backlog

| ID | Priority | Status | Area | Item | Acceptance criteria |
|---|---|---|---|---|---|
| GOV-001 | P0 | Done | Governance | Establish initial baseline governance documents | Initial governance files exist and have validation evidence. |
| GOV-002 | P0 | Todo | Governance | Align repository guidance with governance baseline | `AGENTS.md` references active authoritative documents without duplicating policy. |
| GOV-003 | P0 | Done | Governance | Implement the approved frozen Governance architecture | Approved directories and documents exist, active references resolve, legacy `PROJECT_CHARTER.md` is unchanged, Master Charter is absent, validation passes, and Draft PR #1 is approved. |
| GOV-004 | P0 | Todo | Governance | Create Master Project Charter Chapter 1 | After PR #1 is merged, a separate PR creates only root `MASTER_PROJECT_CHARTER.md` with Vision, Mission, Founder Principle, and Project Promise; no additional chapter is included. |
| DOC-001 | P0 | Todo | Documentation | Define documentation templates and lifecycle | Templates exist for requirements, architecture decisions, test reports, and release notes, with owners and status conventions. |
| ARC-001 | P0 | Todo | Architecture | Define WordPress project and module architecture | Architecture documents define physical module boundaries, shared layers, data flow, extension points, security boundaries, and deployment assumptions. |
| DES-001 | P0 | Todo | Design | Establish design system foundation | Tokens, responsive breakpoints, accessibility rules, and core shared components are specified and demonstrable. |
| DASH-001 | P0 | Todo | Dashboard | Define dashboard and widget framework | Requirements and architecture cover layout, widget registration, states, permissions, responsiveness, and extensibility. |
| CALC-001 | P0 | Todo | Calculator | Define calculator framework | Schema covers variables, units, validation, formulas, precision, source traceability, errors, and test vectors. |
| REF-001 | P0 | Todo | Reference | Define engineering reference framework | Taxonomy, content model, search, citations, revision status, SEO, and relationships are specified. |
| QA-001 | P0 | Todo | Quality | Establish QA strategy and result template | QA documents define test levels, environments, evidence requirements, severity, and release gates. |
| OPS-001 | P0 | Done | Repository | Connect the local project to the approved GitHub repository | Local `main` tracks the approved origin and connection evidence is recorded. |
| OPS-002 | P0 | Done | Repository | Publish the local project foundation to GitHub | Project foundation is committed, pushed, and available in Draft PR #1. |

## Status Definitions

- `Todo`: Approved concept but not started.
- `In Progress`: Active work with an identified owner or current execution.
- `Blocked`: Cannot proceed until a recorded dependency or decision is resolved.
- `Review`: Implementation is complete and awaits verification or approval.
- `Done`: Acceptance criteria and required evidence are satisfied.

## Backlog Rules

- Every material change must reference an existing ID or add a new one.
- Priority order is `P0`, `P1`, `P2`, then `P3`.
- Moving an item to `Done` requires acceptance evidence and applicable QA records.
- New scope must not be silently added to an unrelated backlog item.
