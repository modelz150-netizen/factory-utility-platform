# PCVue Offline Data Collector V1 1.0.0-rc6.1 Change and Validation Report

| Field | Value |
|---|---|
| Status | Release candidate for human review; Production execution not approved |
| Date | 2026-08-12 |
| Backlog | `PCV-001` |
| Architecture decision | `ADR-002` |
| Deployment ZIP | `PCVue_Offline_Data_Collector_V1_1.0.0-rc6.1.zip` |
| ZIP SHA-256 | `8f50f3326ec9e0388ba6ff6565cdb77bb86aa1b6ad7e6c41065ed52af74059dd` |

## Change summary

- Classified `AdditionalProjectRoots.txt` as mutable operator configuration.
- Removed it from and prohibited it in `PACKAGE_SHA256SUMS.txt`.
- Preserved immutable SHA-256 fail-closed checks for Collector, validator, launcher, policy, schema/configuration and field documents.
- Added runtime configuration SHA-256 audit and automatic inclusion in the collection Manifest.
- Added `OPERATOR_APPROVED` root evidence containing path SHA-256 and explicit validation result.
- Enforced absolute local path, verified local drive, system/user-profile exclusion and reparse-ancestor rejection.

## Validation summary

All RC6.1 security regression checks passed under Windows PowerShell 5.1.19041.6456. Detailed observed evidence is in `05_QA/2026-08-12_PCV-001_RC61_OPERATOR_CONFIGURATION_TEST_REPORT.md`.

The final ZIP was extracted and statically validated again. Its external SHA-256 matched, it contained 13 deployment files, included the mutable input file, excluded that input from the immutable baseline, and contained no prior collection output.

## Deployment and rollback

This package has not been run on Production SCADA. Deployment requires existing OT/security and field-use approval. Rollback consists of stopping before execution and using the previously approved package artifact; no system configuration, service, registry, firewall, PLC, OPC or PCVue state is changed by package replacement.

## Known limitation

The exact Production `D:\Project Files` directory was not accessible in the development environment. Its input syntax was validated with the required fixture; physical existence, drive type, readability, reparse status and project signature will be checked fail-closed at Production runtime only after separate authorization.
