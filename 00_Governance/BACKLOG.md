# Product Backlog

| ID | Priority | Status | Area | Item | Acceptance criteria |
|---|---|---|---|---|---|
| GOV-001 | P0 | Done | Governance | Establish initial baseline governance documents | Initial governance files exist and have validation evidence. |
| GOV-002 | P0 | Todo | Governance | Align repository guidance with governance baseline | `AGENTS.md` references active authoritative documents without duplicating policy. |
| GOV-003 | P0 | Done | Governance | Implement the approved frozen Governance architecture | Approved directories and documents exist, active references resolve, legacy `PROJECT_CHARTER.md` is unchanged, Master Charter is absent, validation passes, and Draft PR #1 is approved. |
| GOV-004 | P0 | Done | Governance | Create Master Project Charter Chapter 1 | Root `MASTER_PROJECT_CHARTER.md` contains approved Vision, Mission, Founder Principle, and Project Promise only; PR #2 is merged. |
| GOV-005 | P0 | Done | Governance | Separate Founder and Chief AI authority | Approved Chapter 7 distinguishes constitutional stewardship from delegated AI authority without adding routine operational burden to the Founder. |
| GOV-006 | P0 | Done | Governance | Define Chief AI accountability and operational boundaries | Approved Chapter 7 defines responsibilities, prohibited authority, escalation, evidence, lifecycle accountability, and human authority boundaries. |
| GOV-007 | P0 | Done | Governance | Define Founder succession and constitutional stewardship | Chapter 8 defines continuity, temporary delegation, incapacity, succession, and transfer of constitutional stewardship and was approved and merged through PR #9. |
| GOV-008 | P0 | Done | Governance | Define the constitutional amendment process | Approved Chapter 9 defines constitutional change principles, authority, constraints, review, versioning, effective date, and integrity without prescribing operational workflows. |
| GOV-009 | P0 | Done | Governance | Define Engineering Truth | Approved Chapter 2 defines Engineering Truth as evidence-based, traceable, professionally reviewable, uncertainty-aware engineering knowledge. |
| GOV-010 | P1 | Todo | Governance | Normalize Project and Platform terminology | The appropriate Documentation chapter defines when to use Project, Product, Platform, Repository, and Organization. |
| GOV-011 | P1 | Todo | Governance | Standardize Governance modal terminology | The appropriate Documentation or Governance chapter defines the normative meaning of `shall`, `must`, `may`, `should`, and related terms. |
| GOV-012 | P0 | Done | Governance | Create Master Project Charter Chapter 2 | PR #3 merged approved Chapter 2, Engineering Philosophy, while preserving Chapter 1 and the frozen Governance architecture. |
| GOV-013 | P0 | Done | Governance | Create Master Project Charter Chapter 3 | PR #4 merged approved Chapter 3, Core Principles, while preserving Chapters 1 and 2 and the frozen Governance architecture. |
| GOV-014 | P0 | Done | Governance | Create Master Project Charter Chapter 4 | PR #5 merged approved Chapter 4, Engineering Standards, while preserving Chapters 1 through 3 and lower-level Standards responsibilities. |
| GOV-015 | P0 | Done | Governance | Create Master Project Charter Chapter 5 | PR #6 merged approved Chapter 5, Quality Principles, while preserving Chapters 1 through 4 and introducing no later chapter. |
| GOV-016 | P0 | Todo | Governance | Mark the legacy Project Charter as Superseded | After dedicated approval, `PROJECT_CHARTER.md` clearly identifies the root Master Project Charter as its replacement without deleting historical content or changing the frozen architecture. |
| GOV-017 | P0 | Done | Governance | Complete the Chapters 1-5 Milestone Review | The CTO accepted the Milestone Review, confirmed Chapters 1 through 5 constitutionally coherent, and authorized Chapter 6. |
| GOV-018 | P0 | Done | Governance | Create Master Project Charter Chapter 6 | PR #7 merged approved Chapter 6, Validation Rules, after QA and CTO review while preserving Chapters 1 through 5. |
| GOV-019 | P0 | Done | Governance | Create Master Project Charter Chapter 7 | PR #8 merged approved Chapter 7 after final authority-boundary validation while preserving Chapters 1 through 6. |
| GOV-020 | P0 | Done | Governance | Create Master Project Charter Chapter 8 | PR #9 added only Chapter 8, preserved approved Chapters 1 through 7, passed independent validation and CTO review, and was merged without introducing a later chapter. |
| GOV-021 | P0 | Done | Governance | Create Master Project Charter Chapter 9 | PR #10 added only Chapter 9, preserved approved Chapters 1 through 8, passed independent validation and CTO review, and was merged without introducing Chapter 10. |
| GOV-022 | P0 | Review | Governance | Complete the Chapters 1 through 9 Master Charter Architecture Audit | The formal report evaluates constitutional consistency, duplication, hierarchy, authority, terminology, references, dependencies, completeness, simplification, and v1.0 readiness and awaits CTO approval before Chapter 10 begins. |
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
