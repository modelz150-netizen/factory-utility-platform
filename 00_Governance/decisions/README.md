# Architecture Decision Records

This directory stores durable Architecture Decision Records (ADRs). Use an ADR when a decision changes a system boundary, creates a long-lived constraint, introduces a significant dependency, changes a data contract, affects security or privacy, or creates migration and compatibility obligations.

## Naming

```text
ADR-NNNN-short-kebab-case-title.md
```

Numbers are sequential and never reused. Accepted ADRs are not rewritten to hide history; a later ADR supersedes them.

## Lifecycle

`Proposed` -> `Accepted` -> `Superseded` or `Deprecated`

An ADR records context, decision, alternatives, consequences, validation, ownership, and links to backlog items and pull requests. The template is maintained in `../templates/ADR_TEMPLATE.md`.
