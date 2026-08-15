# Git Version and Release Standard

## Source-of-truth model

GitHub Private is the source of truth for source, governance, design, sanitized documentation, synthetic fixtures and release manifests. Production OT data, secrets, raw Collector output and deployment staging are excluded.

## Naming

| Item | Standard | Example |
|---|---|---|
| Phase | Phase N or Phase N.M | Phase 4.2 |
| Product version | SemVer | 1.2.0 |
| Release candidate | SemVer prerelease | 1.2.0-rc.1 |
| Collector package | Product_Component_1.2.0-rc.1 | PCVue_VAREXP_Minimal_Hierarchy_Pilot_1.0.0-rc.1 |
| Commit | Conventional type + scope | feat(pcvue): add context-aware hierarchy pilot |
| Branch | type/issue-short-name | feat/pcv-phase42-hierarchy-pilot |
| Tag | component/version | pcvue-hierarchy-pilot/v1.0.0-rc.1 |

Do not mix Phase labels into SemVer. Phase identifies program scope; version identifies an artifact.

## Commit and release rules

- One coherent change per commit; no generated output or OT evidence.
- Pull request required for main.
- Checks: static/security, unit/fixture, PowerShell 5.1 where applicable, secret scan, forbidden-path scan, package manifest verification.
- Release manifest records source commit, toolchain, test report links, package SHA-256 and authorization state.
- Binary ZIPs belong in private GitHub Release assets after approval, not duplicated across source, QA, Release and USB folders.
- RC tags are annotated and immutable; final tags require explicit release approval.
- Home and company machines clone from GitHub Private and use machine-local environment files excluded by Git.

## Definition of Done

1. Scope and approval recorded.
2. Source and durable design documents reviewed.
3. Synthetic tests and security gates pass.
4. No Production/secret/generated data in staged set.
5. Release manifest and checksums verified.
6. Documentation/backlog/changelog current.
7. Pull request reviewed and merged.
8. Tagged/released only after explicit approval.
9. Rollback and provenance recorded.
