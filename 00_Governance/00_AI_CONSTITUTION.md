# AI Constitution

| Field | Value |
|---|---|
| Project | Factory Utility Platform |
| Status | Active |
| Version | 1.0.0 |
| Effective date | 2026-08-05 |
| Owner | Project owner |

## Purpose

This constitution defines the mandatory operating rules for AI-assisted work in this repository. It has precedence over convenience, speed, and undocumented conversational decisions. User instructions have the highest authority; this document governs execution when those instructions do not explicitly override it.

## Non-negotiable Rules

1. Store every material decision and deliverable in the actual project repository. A chat response alone is not a completed deliverable.
2. Before writing code, inspect the applicable governance documents, repository structure, and existing implementation for overlap.
3. Update `04_BACKLOG.md` and `05_CHANGELOG.md` whenever project files or scope change.
4. Save each artifact in the designated folder defined by `01_PROJECT.md` and `02_STANDARDS.md`.
5. After implementation, run proportionate verification and record results under `05_QA`.
6. Never delete, replace, or destructively reset a working file without explicit user approval.
7. Do not duplicate functionality. Extend or reuse existing components, services, utilities, schemas, and documentation where practical.
8. Record important architecture decisions, assumptions, risks, and tradeoffs in the repository.
9. Treat security, privacy, accessibility, performance, SEO, responsiveness, and error handling as production requirements.
10. Never claim that a test passed unless it was actually executed and its result was observed.

## Required Work Sequence

1. Read the six governance baseline documents.
2. Inspect relevant files and search for existing functionality.
3. Identify the related backlog item or add one before implementation.
4. Design the smallest reusable change consistent with project architecture.
5. Implement without altering unrelated user work.
6. Test in proportion to the risk and record evidence in `05_QA`.
7. Update documentation, backlog status, and changelog.
8. Report changed files, verification results, decisions, and remaining risks.

## Decision Authority

- The user approves product direction, destructive changes, material scope expansion, and releases.
- The engineering lead may make reversible implementation decisions within approved scope.
- Assumptions that materially affect scope, cost, safety, data, or architecture must be documented and raised to the user.

## Definition of Done

Work is complete only when the requested artifact exists in the repository, applicable documentation is current, tests have been run and recorded, backlog and changelog entries are current, and no known critical issue is concealed.

## Amendment

Changes to this constitution require an explicit user instruction and a corresponding changelog entry.
