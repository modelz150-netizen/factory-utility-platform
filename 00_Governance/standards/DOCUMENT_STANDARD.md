# Document Standard

| Field | Value |
|---|---|
| Status | Active |
| Version | 1.0.0 |
| Owner | Documentation steward |

## Purpose

Define how project knowledge is created, located, reviewed, referenced, versioned, and retired so the repository remains usable over a ten-year horizon.

## Single Responsibility

- Each document owns one durable responsibility.
- Link to an authoritative statement instead of copying it.
- Separate stable policy from live status, historical evidence, and source research.
- Keep operational registers concise and move durable rationale into the appropriate charter, standard, architecture document, or ADR.

## Required Metadata

Normative documents include Status, Version, Owner, effective or updated date, review cycle when appropriate, and authority or derivation. Historical records include date, scope, owner or executor, and result.

## Placement

| Content | Location |
|---|---|
| Governance and policy | `00_Governance` |
| Product requirements and acceptance criteria | `01_Product` |
| Validated formulas and domain references | `02_Engineering` |
| Source and implementation design | `03_Development` |
| Design system and UX specifications | `04_Design` |
| Test plans and executed evidence | `05_QA` |
| Business artifacts | `06_Business` |
| Release and rollback artifacts | `07_Release` |
| Research and imported source material | `99_Knowledge` |

## Writing and Linking

- Use Markdown for repository-native documents.
- Use descriptive headings, relative repository links, and language appropriate to the target reader.
- Define acronyms and use consistent product terminology.
- Use Mermaid only when it materially clarifies relationships or sequence.
- Avoid undocumented claims, broken links, ambiguous status, and time-sensitive statements without dates.

## Lifecycle

Documents use `Draft`, `Review`, `Active`, `Superseded`, or `Archived`. A superseded document remains accessible, identifies its replacement, and must not present itself as active authority. Deletion requires explicit approval and proof that no required history or reference is lost.

## Review

Material documentation changes require backlog and changelog updates. Review checks responsibility boundaries, source authority, links, terminology, metadata, duplication, and rendering.
