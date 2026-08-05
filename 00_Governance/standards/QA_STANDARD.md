# QA Standard

| Field | Value |
|---|---|
| Status | Active |
| Version | 1.0.0 |
| Owner | QA lead |

## Purpose

Define risk-based verification, evidence, defect handling, and release quality gates for software, engineering data, documentation, and Governance changes.

## Test Strategy

Select unit, integration, contract, end-to-end, accessibility, security, performance, compatibility, migration, and manual exploratory checks according to risk. Documentation and Governance changes require structure, link, duplication, authority, and rendering validation.

## Engineering Validation

Calculators and engineering rules require known-answer tests, boundary values, invalid inputs, unit conversions, precision checks, provenance review, and independent verification for safety- or cost-significant results.

## Evidence

Executed results are stored in `05_QA` and include date, backlog ID, scope, environment, method or command, expected result, observed result, status, and known gaps. Missing tools or environments are recorded as gaps and never reported as passes.

## Defects

Defects include severity, user or engineering impact, reproduction conditions, evidence, affected versions, ownership, and disposition. Critical correctness, security, privacy, data-loss, or release-recovery defects block release.

## Quality Gates

- Acceptance criteria are satisfied.
- Required automated and manual checks pass.
- No unresolved blocking defect remains.
- Security, accessibility, performance, and compatibility checks match the risk.
- Documentation, backlog, changelog, migration, and rollback information are current.
- Residual risks are visible to the approving owner.

## Independence and Truthfulness

Quality status must reflect observed evidence. Schedule pressure cannot convert a failed, skipped, or unavailable check into a pass. Material exceptions require explicit approval, rationale, expiry or remediation, and release documentation.
