# Release Standard

| Field | Value |
|---|---|
| Status | Active |
| Version | 1.0.0 |
| Owner | Release manager |

## Purpose

Define the minimum controls for preparing, approving, deploying, observing, and recovering a production release.

## Release Readiness

A release candidate requires approved scope, completed acceptance criteria, passing required QA gates, documented known issues, security and privacy review proportional to risk, migration instructions, compatibility assessment, observability readiness, and a tested rollback or recovery plan.

## Versioning and Notes

- Use a documented versioning scheme before the first production release.
- Release notes identify user-visible changes, fixes, security implications, breaking changes, migrations, known issues, and rollback considerations.
- Every release maps to immutable source commits and approved pull requests.

## Deployment

- Deployment environments, configuration, secrets, and access must be separated.
- Back up affected data before irreversible migration.
- Validate the target environment and dependencies before deployment.
- Use repeatable deployment steps and prohibit undocumented production edits.
- Capture deployment executor, time, version, result, and anomalies.

## Verification and Observation

Perform smoke checks after deployment and observe errors, performance, security signals, and critical product workflows for a defined period. A release is not complete until post-deployment evidence is recorded.

## Rollback and Incident Handling

Define rollback triggers, authority, data implications, procedure, and validation before release. Failed or unsafe releases must favor service and data protection over schedule. Incidents require a factual record and follow-up improvement items.

## Approval

The project owner approves production release policy and material release risk. The release manager verifies evidence and coordinates execution; QA reports quality status independently.
