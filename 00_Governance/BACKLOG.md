# Product Backlog

| ID | Priority | Status | Area | Item | Acceptance criteria |
|---|---|---|---|---|---|
| GOV-001 | P0 | Done | Governance | Establish initial baseline governance documents | Initial governance files exist and have validation evidence. |
| GOV-002 | P0 | Todo | Governance | Align repository guidance with governance baseline | `AGENTS.md` references active authoritative documents without duplicating policy. |
| GOV-003 | P0 | Done | Governance | Implement the approved frozen Governance architecture | Approved directories and documents exist, active references resolve, legacy `PROJECT_CHARTER.md` is unchanged, Master Charter is absent, validation passes, and Draft PR #1 is approved. |
| GOV-004 | P0 | Done | Governance | Create Master Project Charter Chapter 1 | Root `MASTER_PROJECT_CHARTER.md` contains approved Vision, Mission, Founder Principle, and Project Promise only; PR #2 is merged. |
| GOV-005 | P0 | Todo | Governance | Separate Founder and Chief AI authority | The appropriate future AI Governance chapter distinguishes constitutional stewardship from delegated AI authority without adding operational burden to the Founder. |
| GOV-006 | P0 | Todo | Governance | Define Chief AI accountability and operational boundaries | A future Chief AI chapter defines responsibilities, prohibited authority, escalation, evidence, audit, and human accountability boundaries. |
| GOV-007 | P0 | Todo | Governance | Define Founder succession and constitutional stewardship | A future Governance chapter defines continuity, temporary delegation, incapacity, succession, and transfer of constitutional stewardship. |
| GOV-008 | P0 | Todo | Governance | Define the constitutional amendment process | The Charter Change Policy defines proposal, impact review, approval, versioning, effective date, supersession, and emergency limitations. |
| GOV-009 | P0 | Review | Governance | Define Engineering Truth | Chapter 2 defines Engineering Truth as evidence-based, traceable, professionally reviewable, uncertainty-aware engineering knowledge. |
| GOV-010 | P1 | Todo | Governance | Normalize Project and Platform terminology | The appropriate Documentation chapter defines when to use Project, Product, Platform, Repository, and Organization. |
| GOV-011 | P1 | Todo | Governance | Standardize Governance modal terminology | The appropriate Documentation or Governance chapter defines the normative meaning of `shall`, `must`, `may`, `should`, and related terms. |
| GOV-012 | P0 | Review | Governance | Create Master Project Charter Chapter 2 | A separate PR adds only Chapter 2, Engineering Philosophy, preserves approved Chapter 1, and introduces no later chapter. |
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
