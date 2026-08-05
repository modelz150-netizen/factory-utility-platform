# GitHub Standard

| Field | Value |
|---|---|
| Status | Active |
| Version | 1.0.0 |
| Owner | Repository maintainer |

## Purpose

Define the repository collaboration and review controls used to make changes traceable, reversible, and auditable.

## Branches

- `main` is the protected integration branch and represents reviewed project state.
- Material work uses a focused branch created from current `main`.
- Agent-created branches use `agent/<concise-scope>`.
- One branch should represent one coherent review outcome.
- Sequential Master Charter chapters require separate branches and pull requests.

## Commits

- Commit only reviewed scope and stage files intentionally.
- Use concise imperative messages describing the completed change.
- Keep generated binaries, credentials, local tools, and unrelated changes out of commits.
- Do not rewrite shared history or force-push without explicit approval and documented reason.

## Pull Requests

Every material change is reviewed through a pull request unless an approved emergency procedure applies. A pull request describes what changed, why, impact, validation, known risks, migration needs, and related backlog or ADR identifiers.

Draft pull requests are used for work awaiting owner review. A pull request becomes ready only after required evidence exists and its scope matches the approved backlog item.

## Reviews and Merge

- The author must not represent unexecuted checks as passing.
- Unresolved material review comments block merge.
- Governance, architecture, security, release, and breaking changes require review by the accountable owner.
- Merge only after checks and required approvals pass.
- Delete branches only when history is safely retained by the merged pull request and repository policy permits it.

## Repository Protection

Recommended `main` protections include pull-request review, required checks, blocked force pushes, blocked deletion, and resolved conversations. Protection configuration must be verified against the repository plan and owner policy before enforcement.

## Traceability

Link backlog IDs, ADRs, QA evidence, and releases from pull requests where applicable. GitHub is the collaboration record; authoritative product and engineering knowledge remains in repository documents.
