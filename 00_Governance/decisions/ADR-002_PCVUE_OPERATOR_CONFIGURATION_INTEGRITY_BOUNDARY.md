# ADR-002: PCVue Operator Configuration Integrity Boundary

| Field | Value |
|---|---|
| Status | Active |
| Version | 1.0.0 |
| Date | 2026-08-12 |
| Owner | Engineering lead |
| Backlog | `PCV-001` |

## Context

RC6 included `AdditionalProjectRoots.txt` in the immutable package checksum baseline even though the file is intentionally edited by an authorized field operator. A valid root entry therefore caused static validation to stop with a package checksum mismatch.

## Decision

The package uses two explicit integrity classes:

- executable, validation, launcher, policy, schema and field-use files remain `IMMUTABLE_SECURITY_CRITICAL` and retain pre-execution SHA-256 fail-closed validation;
- `AdditionalProjectRoots.txt` is `MUTABLE_OPERATOR_CONFIGURATION`, is prohibited from the immutable baseline, and is SHA-256 hashed into runtime audit and collection integrity evidence.

Operator inputs remain deny-by-default. Only absolute local paths on verified ready local fixed or removable drives may proceed. Drive roots, relative paths, UNC/device/network/mapped paths, Windows/system/user-profile locations and reparse points are rejected with evidence. Operator approval is evidence, not authority to bypass project-signature confirmation or field-use approval.

## Consequences

- Authorized configuration changes no longer invalidate immutable package files.
- Tampering with executable or security-critical files still blocks execution before collection.
- Every mutable configuration state and root decision is independently auditable.
- Production SCADA execution remains outside this change and requires separate approval.
