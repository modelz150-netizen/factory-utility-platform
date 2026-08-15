# Phase 4 Limited VAREXP Tag Pilot Collector Implementation Report

Package: PCVue_VAREXP_Limited_Tag_Pilot_1.0.0-rc1
Production execution: NOT PERFORMED / NOT APPROVED

## Implemented scope

- Exact five-file VAREXP allowlist with safe SourceFile IDs only.
- Source schema discovery and verification before data rows.
- Source-specific schema variant and SHA-256 provenance.
- Exactly 262 fields required for each accepted data record.
- Positional selection of exactly 17 approved fields.
- 20 data logical records and 256 KiB per file, 100 emitted rows globally.
- OriginalHeader provenance paired with every approved positional value.
- Raw rows and 245 excluded values never serialized.
- Secret, credential, endpoint, network, and IP patterns fail closed without raw values.
- DAT, XLSX, XML, HISTO, network, DB, PLC, OPC, service/process operations absent.

## Outputs

TAG_DATA.csv, FILE_STATUS.csv, SCHEMA_PROVENANCE.csv, FINAL_STATUS.txt, SHA256SUMS.txt, result ZIP, and external ZIP SHA-256.

## Validation

Static/security, PowerShell 5.1 E2E, fixtures, read boundaries, source immutability, leakage searches, and internal/external hashes passed.

## Decision

READY_FOR_PRODUCTION_PILOT_APPROVAL

This status requests a separate Production execution decision; it does not authorize execution.
