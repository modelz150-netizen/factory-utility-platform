# Governance

| Field | Value |
|---|---|
| Architecture status | Approved and frozen |
| Governance status | Approved |
| Project status | Foundation Complete |
| Next phase | Governance Implementation |
| Effective date | 2026-08-05 |

## Purpose

This directory contains the authoritative governance system for the Factory Utility Platform. It separates durable policy, product direction, architecture, standards, operational registers, decisions, and templates so that each document has one responsibility.

`MASTER_PROJECT_CHARTER.md` is intentionally absent during Phase 1. After this governance architecture is reviewed and merged, Chapter 1 will be proposed separately at the repository root. No additional charter chapter may be written without sequential review and approval.

## Authority and Document Map

Until the Master Project Charter is accepted, `00_AI_CONSTITUTION.md` is the highest active repository policy beneath explicit user approval. After acceptance, the Master Project Charter will become the highest repository document and all documents below will derive authority from it.

| Document | Responsibility | Change pattern |
|---|---|---|
| `00_AI_CONSTITUTION.md` | Mandatory AI-assisted operating rules | Constitutional review |
| `03_PRODUCT_CHARTER.md` | Product identity, users, scope, and outcomes | Product governance review |
| `ARCHITECTURE.md` | System boundaries, architecture model, quality attributes, and decision process | Architecture review and ADR |
| `AI_STATUS.md` | Live operational dashboard and next approved action | Updated with material workflow changes |
| `standards/DEVELOPMENT_STANDARD.md` | Software development rules | Standards review |
| `standards/DOCUMENT_STANDARD.md` | Documentation lifecycle and metadata | Standards review |
| `standards/GITHUB_STANDARD.md` | Repository, branch, commit, and pull-request rules | Standards review |
| `standards/RELEASE_STANDARD.md` | Release readiness, deployment, and rollback rules | Standards review |
| `standards/QA_STANDARD.md` | Verification strategy, evidence, and quality gates | Standards review |
| `ROADMAP.md` | Strategic sequencing and phase outcomes | Product planning review |
| `BACKLOG.md` | Approved executable work and acceptance criteria | Continuous operations |
| `CHANGELOG.md` | Notable repository changes | Every material change |
| `decisions/` | Durable architecture decision records | One ADR per material decision |
| `templates/` | Reusable governance artifact templates | Standards review |
| `PROJECT_CHARTER.md` | Legacy project charter retained unchanged pending Master Charter acceptance | No change during Phase 1 |

## Repository Governance Flow

```mermaid
flowchart TD
    U["Explicit owner approval"] --> C["Master Project Charter - planned"]
    C --> A["AI Constitution"]
    C --> P["Product Charter"]
    C --> R["Architecture"]
    A --> S["Standards"]
    P --> RM["Roadmap"]
    R --> D["Architecture Decisions"]
    S --> B["Backlog"]
    RM --> B
    B --> Q["QA and Release Evidence"]
    B --> ST["AI Status"]
    B --> CL["Changelog"]
```

The planned Master Project Charter node does not become active authority until its first approved chapter is merged.

## Frozen Architecture Policy

The directory responsibilities and governance layers documented here are frozen as of 2026-08-05. Future structural changes require a separate written proposal, impact analysis, explicit approval, backlog item, changelog entry, validation evidence, and dedicated pull request before implementation.
