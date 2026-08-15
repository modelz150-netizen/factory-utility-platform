# Phase 4.2 Minimal Hierarchy Pilot Collector Change and Validation Report

| Field | Value |
|---|---|
| Version | 1.0.0-rc1 |
| Date | 2026-08-14 |
| Final status | **READY_FOR_PHASE4_2_PRODUCTION_PILOT_APPROVAL** |
| Production execution | NOT PERFORMED |

## Changes

- Added only VAREXP_COL_003–005 to the existing 17-field positional allowlist.
- Separated VERSION_METADATA, SCHEMA_HEADER, DATA_RECORD and UNKNOWN detection contexts.
- Accepted local Windows path separators only in validated discarded VERSION metadata.
- Retained fail-closed credential/token/key/certificate/secret checks.
- Added candidate-hash, four-level uniqueness, null/empty, duplicate and Description/Class/Domain conflict metrics.
- Capped identity state at STRUCTURALLY_VALIDATED; CONFIRMED is never emitted.
- Retained five-source, 20-record/file, 256 KiB/file and 100-record global limits.

## Validation

Windows PowerShell 5.1 static/security and complete launcher E2E passed. VERSION+schema, schema-first, secret, 261/263, 20/21, 256 KiB, 100/101, leakage, source immutability and ZIP/internal/external SHA tests passed. Production data was not used or packaged.

## Release hash

SHA-256: AFABFE571BBB8C063BA79E42C226CF715AD4E768CF9BCD8766F8BB4964406DD1
