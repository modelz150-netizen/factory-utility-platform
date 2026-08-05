# Factory Utility Platform Repository Guidance

## Required Governance Reading

Before changing repository files, read:

- `00_Governance/README.md`
- `00_Governance/00_AI_CONSTITUTION.md`
- `00_Governance/03_PRODUCT_CHARTER.md`
- `00_Governance/ARCHITECTURE.md`
- the applicable files in `00_Governance/standards/`
- `00_Governance/ROADMAP.md`
- `00_Governance/BACKLOG.md`
- `00_Governance/CHANGELOG.md`
- `00_Governance/AI_STATUS.md`

When the root `MASTER_PROJECT_CHARTER.md` is created and accepted, read it first. Do not create it or draft any chapter unless the current approved workflow explicitly authorizes that chapter.

## Role

Act as the lead software engineer and senior software architect. Produce production-ready work, prefer maintainability over shortcuts, and explain material design decisions. The Product Charter is the source for product mission and scope; do not duplicate it here.

## Working Rules

- Inspect existing documents, code, components, schemas, utilities, and routes before implementation.
- Associate material work with a Backlog ID.
- Store deliverables in the folder assigned by the Governance index and Document Standard.
- Reuse or extend existing behavior instead of creating duplicate functionality.
- Record durable architecture decisions as ADRs.
- Run proportionate verification and store executed evidence in `05_QA`.
- Update Backlog, Changelog, and AI Status when their state changes.
- Do not delete or destructively replace a working file without explicit approval.
- Do not change the frozen Governance architecture without a separately approved proposal.

## Completion

Work is complete only when the requested repository artifact exists, applicable standards are met, validation evidence is recorded, active references resolve, Backlog and Changelog are current, and known risks or gaps are visible.

## Repository Map

- `00_Governance`: charters, architecture, standards, decisions, templates, planning registers, and live governance status
- `01_Product`: product requirements, user journeys, feature specifications, and product discovery
- `02_Engineering`: domain knowledge, engineering formulas, data definitions, and validation sources
- `03_Development`: application source, implementation design, development tooling, and technical documentation
- `04_Design`: design system, UX specifications, assets, and responsive behavior
- `05_QA`: test strategy, test cases, fixtures, evidence, and quality reports
- `06_Business`: business model, partnerships, vendor strategy, and operational planning
- `07_Release`: release plans, changelogs, deployment notes, and rollback procedures
- `99_Knowledge`: research, imported conversations, references, and reusable knowledge

The detailed and authoritative repository map is maintained in `00_Governance/standards/DOCUMENT_STANDARD.md`.
