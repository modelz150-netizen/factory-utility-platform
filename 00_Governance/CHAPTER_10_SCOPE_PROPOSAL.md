# Chapter 10 Scope Proposal — Documentation Governance

| Field | Value |
|---|---|
| Status | Review |
| Version | 0.1.0 |
| Updated | 2026-08-06 |
| Owner | Constitutional steward |
| Backlog ID | GOV-024 |
| Proposed chapter | Chapter 10 — Documentation Governance |
| Authority | Scope proposal derived from the approved v1.0 Completion Plan |
| Constitutional authority | None |

## 1. Purpose

Chapter 10 is proposed to establish the constitutional principles that make documented knowledge authoritative, accountable, understandable, and governable across the life of the Factory Utility Platform. The Platform depends on engineering claims, decisions, responsibilities, standards, and status that must remain distinguishable from informal conversation, transient implementation state, and unsupported assertion.

This responsibility belongs in the Master Charter because documentation is not merely a file format or administrative practice. At constitutional level it determines how the Platform recognizes authoritative knowledge, assigns stewardship, communicates normative force, represents status truthfully, and prevents undocumented or ambiguous statements from acquiring hidden authority.

Lower-level Governance documents may define placement, templates, metadata fields, review mechanics, and tools. They cannot decide what gives documentation constitutional legitimacy or alter the authority hierarchy established by the Charter.

## 2. Constitutional Scope

### 2.1 Topics That Shall Be Included

Chapter 10 shall define only enduring Documentation Governance principles:

1. **Documented authority** — authoritative decisions, obligations, claims, and status require an accountable, discoverable record appropriate to their consequence.
2. **Source-of-truth discipline** — every governed responsibility has one identifiable authoritative source, with references preferred over conflicting duplication.
3. **Document classes and normative force** — constitutional, normative, decision, evidence, operational, historical, and informative records remain distinguishable.
4. **Ownership and stewardship** — every authoritative document has accountable stewardship without implying that the steward may exceed the document's governing authority.
5. **Truthful lifecycle state** — draft, review, approved or active, superseded, withdrawn, and archived states must not be represented as equivalent.
6. **Change accountability** — material documentation change preserves responsible authority, rationale, review basis, and relationship to prior authority.
7. **Clarity and interpretability** — authoritative language must be sufficiently precise for affected people to understand duties, permissions, uncertainty, and boundaries.
8. **Terminology governance** — Project, Product, Platform, Repository, and Organization receive stable constitutional meanings appropriate to GOV-010.
9. **Normative modal governance** — shall, must, should, may, and related terms receive stable meanings appropriate to GOV-011.
10. **Accessibility and discoverability principles** — governed information must be usable and findable by authorized affected people in proportion to consequence.
11. **Conflicts and precedence** — documentation conflicts are resolved through Chapter 8's authority hierarchy and cannot be settled by recency, file location, or tool state alone.
12. **Chapter boundary** — operational methods and Project Memory responsibilities are delegated explicitly to their proper owners.

### 2.2 Topics That Shall Not Be Included

Chapter 10 shall not define:

- directory structures, filenames, templates, Markdown syntax, metadata schemas, style guides, review schedules, or publishing tools;
- Git branches, commits, Pull Requests, repository permissions, or merge procedures;
- sprint tickets, workflow states, planning ceremonies, or delivery dashboards;
- release notes, deployment records, version publication mechanics, or rollback procedures;
- retention periods, backup media, migration procedures, archival storage, disaster recovery, or knowledge-transfer operations;
- detailed provenance models, historical reconstruction procedures, institutional-memory continuity, or succession of knowledge custody;
- Charter amendment procedure already governed constitutionally by Chapter 9;
- the authority hierarchy, delegation model, or conflict escalation already owned by Chapter 8; or
- tool-specific AI documentation, prompt, automation, or content-generation procedures.

These exclusions belong respectively to the Document Standard, GitHub Standard, future Sprint and Workflow Governance, Release Standard, future Project Memory chapter, lower-level Charter Change Policy, and responsible operational documents.

## 3. Dependencies

### 3.1 Previous Chapters Referenced

| Chapter | Dependency |
|---|---|
| Chapter 1 | Project Promise requires enduring, trustworthy engineering practice. |
| Chapter 2 | Engineering Truth requires evidence, traceability, reproducibility, and visible uncertainty. |
| Chapter 3 | Core Principles require one coherent Platform, institutional memory, accessibility, and controlled change. |
| Chapter 4 | The Standards system needs clear normative authority, stewardship, lifecycle, and conflict rules. |
| Chapter 5 | Truthful quality state depends on reliable documentation of defects, debt, limitations, and residual risk. |
| Chapter 6 | Validation requires reproducible evidence, claims, context, decisions, and validity state. |
| Chapter 7 | AI evidence and decision records must remain subordinate to accountable human authority. |
| Chapter 8 | Governance hierarchy determines document precedence, decision accountability, and escalation. |
| Chapter 9 | Charter change and version integrity constrain constitutional documentation change. |

Chapter 10 shall reference these responsibilities without restating or redefining them.

### 3.2 Future Chapters Depending on Chapter 10

| Future chapter | Dependency on Chapter 10 |
|---|---|
| Chapter 11 — Project Memory | Uses authoritative document classes, stewardship, lifecycle, and terminology as the basis for durable memory and preservation. |
| Chapter 12 — Sprint and Workflow Governance | Requires truthful work state, accountable decisions, and a defined source of truth. |
| Chapter 13 — GitHub Governance | Applies documentation authority and change accountability to repository collaboration records. |
| Chapter 14 — Release Governance | Depends on authoritative evidence, version state, approvals, and release records. |
| Chapter 15 — Continuous Improvement | Requires trustworthy learning records without silent Governance drift. |
| Chapter 16 — Success Criteria and Constitutional Completion | Requires stable terminology and auditable evidence of completion. |

The approved future chapter order remains logically valid.

## 4. Governance Boundaries

| Layer | Chapter 10 responsibility | Explicit boundary |
|---|---|---|
| Constitutional principles | Define why documentation can carry authority, how normative force and stewardship remain accountable, and how truth, lifecycle, terminology, and precedence are protected. | Master Charter owns enduring principles only. |
| Standards | Translate principles into metadata, document classes, placement, writing, linking, review, lifecycle, and maintenance requirements. | Document Standard remains the normative implementation authority and may not override the Charter. |
| Operational procedures | Execute drafting, review routing, publication, archiving, migration, access, and tool-specific work. | Procedures remain replaceable and may not create constitutional authority. |

Project Memory is adjacent but separate. Chapter 10 governs documented authority and meaning; Chapter 11 will govern durable preservation, provenance, continuity, recovery, and institutional recall.

## 5. Expected Deliverables

If this proposal is approved, the authorized Chapter 10 Pull Request shall contain:

1. Chapter 10 text only within MASTER_PROJECT_CHARTER.md.
2. Constitutional sections corresponding to the included scope in Section 2.1.
3. Explicit terminology definitions resolving GOV-010.
4. Explicit normative modal definitions resolving GOV-011.
5. A chapter boundary preserving the responsibilities of Chapter 11 and lower-level Standards.
6. Updated AI Status, Backlog, and Changelog records required by Governance.
7. Independent QA evidence covering duplication, authority, terminology, references, Markdown, and unintended chapter changes.
8. A CTO review request before merge.

The deliverables shall not include Chapter 11 text, amendments to Chapters 1 through 9, or changes to the frozen Governance Architecture.

## 6. Validation Criteria

Chapter 10 shall be validated against the following:

- constitutional consistency with Chapters 1 through 9;
- no duplicate source of authority;
- clear separation among documentation, Project Memory, GitHub, workflow, and release responsibilities;
- one accountable meaning for Project, Product, Platform, Repository, and Organization;
- one accountable normative meaning for shall, must, should, and may;
- alignment with the Document Standard without copying its operational rules;
- correct Governance hierarchy and cross-reference direction;
- no tool-specific or procedural implementation;
- valid Markdown structure;
- no modification of approved chapters;
- no Chapter 11 or later content; and
- independent QA result with no unresolved Critical or Major issue before CTO review.

## 7. Risks

| Risk | Consequence | Proposed control |
|---|---|---|
| Duplicating Chapter 8 | Competing authority and conflict rules | Reference the established hierarchy; do not redefine it. |
| Duplicating Chapter 9 | Documentation change is confused with Charter amendment | Limit Chapter 10 to general documentation authority and lifecycle. |
| Absorbing Project Memory | Chapter 11 loses a coherent responsibility | Exclude preservation, retention, recovery, provenance operations, and institutional recall. |
| Replacing the Document Standard | Constitutional text becomes procedural and brittle | State principles only and delegate implementation mechanics. |
| Over-defining terminology | Definitions become product or organization design | Define only distinctions necessary for constitutional interpretation. |
| Modal ambiguity remains | Duties and permissions remain inconsistent | Resolve GOV-011 explicitly and validate every normative term. |
| Existing language conflicts with new definitions | Approved chapters acquire unintended reinterpretation | Perform a cross-chapter terminology impact review before approval. |
| Scope expansion into GitHub, workflow, or release | Future chapter order and single responsibility break down | Enforce the exclusions in Section 2.2 during QA and CTO review. |

## 8. Acceptance Criteria

This Scope Proposal is accepted only when the CTO confirms that:

1. the purpose is constitutional rather than procedural;
2. included and excluded topics are explicit;
3. Documentation Governance and Project Memory remain separate;
4. Chapters 1 through 9 are referenced without duplication;
5. future chapter dependencies remain coherent;
6. GOV-010 and GOV-011 have an appropriate Chapter 10 resolution path;
7. Standards and operational procedures retain their existing responsibilities;
8. risks and validation gates are adequate;
9. no approved chapter or frozen Governance structure requires change; and
10. approval authorizes Chapter 10 drafting only, not Chapter 11 or later work.

Until all acceptance criteria receive explicit approval, Chapter 10 remains unauthorized.
