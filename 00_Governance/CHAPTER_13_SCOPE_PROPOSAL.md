# Chapter 13 Scope Proposal — GitHub Governance

| Field | Value |
|---|---|
| Status | Review |
| Version | 0.1.0 |
| Updated | 2026-08-06 |
| Owner | Constitutional steward |
| Backlog ID | GOV-030 |
| Proposed chapter | Chapter 13 — GitHub Governance |
| Authority | Scope proposal derived from the approved v1.0 Completion Plan |
| Constitutional authority | None |

## 1. Purpose

Chapter 13 is proposed to define the enduring constitutional role of GitHub in preserving the authoritative state, provenance, accountability, and continuity of the Factory Utility Platform Repository.

This responsibility belongs in the Master Charter because repository state is the durable point at which governed intent, approved change, evidence, history, and version identity converge. Lower-level Governance may define commands, settings, workflows, and automation, but it cannot determine the constitutional duties that make the Repository trustworthy across tools, contributors, and generations.

## 2. Constitutional Scope

Chapter 13 shall include only the following enduring GitHub Governance principles:

1. **GitHub as constitutional Source of Truth** — GitHub hosts the authoritative Repository state for governed project artifacts, subject to the authority hierarchy defined by the Charter.
2. **Repository governance principles** — material Repository change remains authorized, attributable, reviewable, traceable, and recoverable.
3. **Repository ownership and stewardship** — constitutional ownership, delegated stewardship, custodial responsibility, and platform-provider custody remain distinguishable.
4. **Branch governance principles** — branches represent bounded, non-authoritative change contexts until governed acceptance integrates them into an authoritative line.
5. **Pull Request governance principles** — Pull Requests provide a governed decision boundary for material Repository change without themselves creating constitutional authority.
6. **Traceability and auditability** — material change remains connected to purpose, accountable participants, decisions, evidence, review, approval, and resulting state.
7. **Version integrity** — named versions and authoritative references identify immutable or controlled Repository states and do not misrepresent approval or release status.
8. **Repository continuity** — loss of a provider, account, maintainer, integration, or operational environment shall not erase constitutional ownership or continuity duties.
9. **Governance evidence preservation** — approvals, reviews, exceptions, validation, and material decision evidence remain durable and appropriately protected.
10. **Constitutional repository responsibilities** — automation, platform permissions, and technical capability cannot create authority or waive Governance.
11. **Chapter boundary** — implementation remains assigned to lower-level Governance.

## 3. Explicit Exclusions

Chapter 13 shall not include:

- Git commands, command syntax, aliases, hooks, or local configuration;
- GitHub CLI installation, authentication, commands, or usage;
- branch creation, naming, synchronization, rebasing, deletion, or recovery procedures;
- Pull Request creation, drafting, review routing, comment resolution, approval, update, or merge procedures;
- merge strategies, merge queues, conflict-resolution methods, or commit-history manipulation;
- CI/CD design or implementation;
- GitHub Actions, workflows, runners, secrets, artifacts, or marketplace integrations;
- Repository settings, rulesets, protections, labels, templates, issue forms, or project boards;
- access configuration, role assignment, permission setup, account administration, or credential management;
- release procedures, deployment, rollback, or environment promotion;
- operational checklists, screenshots, user-interface instructions, or tool-specific guidance.

These subjects belong to the GitHub Standard, Development Standard, Release Standard, security controls, operating procedures, or implementation documentation.

## 4. Dependencies

### 4.1 Previous Chapters Referenced

| Chapter | Dependency |
|---|---|
| Chapter 1 | The Mission and Project Promise require durable stewardship of the Platform's authoritative assets. |
| Chapter 2 | Engineering Truth requires evidence, provenance, uncertainty, and professionally reviewable state. |
| Chapter 3 | Core Principles require traceability, explicit contracts, recoverability, institutional memory, and proportional control. |
| Chapter 4 | Standards derive authority from the Charter and define lower-level Repository requirements and exceptions. |
| Chapter 5 | Quality requires truthful state, independent challenge, visible risk, and prevention of silent degradation. |
| Chapter 6 | Validation governs evidence sufficiency, acceptance, failure response, and revalidation. |
| Chapter 7 | AI participation in Repository work remains delegated, bounded, attributable, and human-accountable. |
| Chapter 8 | Authority, accountability, delegation, escalation, and separation of duties govern Repository decisions. |
| Chapter 9 | Constitutional change cannot be made valid through ordinary Repository capability or workflow. |
| Chapter 10 | Documentation authority, lifecycle, traceability, terminology, and interpretation govern Repository records. |
| Chapter 11 | Project Memory preserves decisions, provenance, continuity, loss visibility, and institutional knowledge. |
| Chapter 12 | Workflow integrity governs planning, review, approval, traceability, completion, and handover associated with Repository change. |

Chapter 13 shall apply these authorities to Repository integrity without redefining their responsibilities.

### 4.2 Future Chapters Depending on Chapter 13

| Future chapter | Dependency on Chapter 13 |
|---|---|
| Chapter 14 — Release Governance | Requires authoritative version identity, traceable approved state, evidence, and continuity. |
| Chapter 15 — Continuous Improvement | Requires trustworthy change history, decisions, outcomes, and learning evidence. |
| Chapter 16 — Success Criteria and Constitutional Completion | Requires auditable proof that the adopted Charter and completion state correspond to authoritative Repository versions. |

The approved future chapter order remains coherent.

## 5. Governance Boundaries

| Layer | Chapter 13 responsibility | Boundary |
|---|---|---|
| Constitutional principles | Define Source-of-Truth status, ownership, stewardship, change integrity, decision boundaries, traceability, version integrity, evidence, and continuity duties. | Independent of commands, interfaces, settings, vendor features, and operating model. |
| Standards | Define required branch and Pull Request controls, evidence, approvals, naming, protection, retention, access, exceptions, and compatible automation. | Standards implement constitutional duties and remain replaceable through governed change. |
| Operational procedures | Execute synchronization, branch and Pull Request work, reviews, merges, administration, recovery, and routine maintenance. | Procedures cannot create constitutional authority, redefine approval, or waive evidence. |

Chapter 8 continues to govern decision authority. Chapter 9 governs constitutional amendment. Chapters 10 through 12 continue to govern documentation, memory, and workflow integrity. Chapter 14 will govern Release Governance.

## 6. Expected Deliverables

If this proposal is approved, the authorized Chapter 13 Pull Request shall contain:

1. Chapter 13 text only within `MASTER_PROJECT_CHARTER.md`.
2. Constitutional sections corresponding to the included scope in Section 2.
3. Explicit separation from authority, amendment, documentation, memory, workflow, and Release responsibilities owned by other chapters.
4. A boundary assigning commands, settings, access configuration, workflows, automation, and procedures to lower-level Governance.
5. Updated AI Status, Backlog, and Changelog records.
6. Independent QA evidence covering constitutional consistency, duplication, hierarchy, authority, references, terminology, exclusions, Markdown, and unintended chapter changes.
7. A CTO review request before merge.

The deliverables shall not include Chapter 14 text, changes to Chapters 1 through 12, or changes to the frozen Governance Architecture.

## 7. Validation Criteria

Chapter 13 shall be validated for:

- constitutional consistency with Chapters 1 through 12;
- no duplication of Chapter 8 authority, Chapter 9 amendment, Chapter 10 documentation, Chapter 11 memory, or Chapter 12 workflow;
- clear distinction between constitutional Source of Truth and operational GitHub hosting;
- unambiguous Repository ownership, stewardship, custody, and decision accountability;
- explicit non-sovereignty of GitHub, automation, permissions, and technical capability;
- correct boundaries for branches, Pull Requests, authoritative state, versions, evidence, and continuity;
- correct dependency boundaries for Chapters 14 through 16;
- no commands, CLI, branch or Pull Request procedures, merge strategy, CI/CD, Actions, settings, access configuration, or tool guidance;
- correct terminology and normative language under Chapter 10;
- valid Markdown structure;
- no modification of approved chapters;
- no Chapter 14 or later content; and
- independent QA with no unresolved Critical or Major issue before CTO review.

## 8. Risks

| Risk | Consequence | Proposed control |
|---|---|---|
| Platform sovereignty ambiguity | GitHub appears to possess constitutional authority | Distinguish hosting custody and technical capability from human and Charter authority. |
| Source-of-Truth overreach | GitHub is treated as authoritative for external engineering reality | Limit authority to governed Repository state; Engineering Truth remains governed by Chapter 2. |
| Duplicating Chapter 8 | Repository mechanics redefine decision rights | Reference Chapter 8 and limit Chapter 13 to Repository integrity. |
| Duplicating Chapter 12 | Pull Requests become a second workflow constitution | Apply Chapter 12 principles without redefining execution governance. |
| Preempting Chapter 14 | Version identity is confused with release approval | Govern Repository version integrity while reserving release readiness and deployment. |
| Vendor lock-in | Continuity becomes dependent on one provider | Preserve portable ownership, recoverability, evidence, and continuity duties. |
| Permission-as-authority | Technical access is mistaken for legitimate authority | State that capability and permission cannot create approval or stewardship authority. |
| History manipulation | Audit evidence becomes incomplete or misleading | Require accountable, visible, recoverable change and protected material evidence. |
| Excessive constitutional detail | Charter becomes coupled to current GitHub features | Keep principles feature-neutral and assign configuration to Standards. |

## 9. Acceptance Criteria

This Scope Proposal is accepted only when the CTO confirms that:

1. GitHub's constitutional role is expressed without granting it sovereignty;
2. Source-of-Truth authority is limited to governed Repository state;
3. Repository ownership, stewardship, custody, and accountability are unambiguous;
4. branches, Pull Requests, traceability, auditability, versions, evidence, and continuity are governed as principles only;
5. Chapters 1 through 12 are referenced without duplication or redefinition;
6. commands, procedures, settings, access, automation, and implementation remain excluded;
7. Release Governance remains reserved for Chapter 14;
8. future Chapters 14 through 16 remain logically ordered;
9. no approved chapter or frozen Governance structure requires change; and
10. approval authorizes Chapter 13 drafting only, not Chapter 14 or later work.

Until explicit approval is recorded, Chapter 13 remains unauthorized.
