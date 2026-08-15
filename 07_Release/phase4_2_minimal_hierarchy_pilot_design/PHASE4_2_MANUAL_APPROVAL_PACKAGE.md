# Phase 4.2 Manual Approval Package

| Field | Value |
|---|---|
| Status | Awaiting user approval |
| Date | 2026-08-14 |
| Recommendation | **READY_FOR_USER_APPROVAL** |

## Requested future authorization

Approve implementation and nonProduction QA of a Minimal Hierarchy Pilot Collector adding only COL_003 (n1/n1(Factory)), COL_004 (n2/n2(System)) and COL_005 (n3/n3(Name)). All remain HIERARCHY_CANDIDATE; meanings are unconfirmed and variant headers are not aliases.

## Fixed safety boundary

- Same verified five files; other 34 excluded.
- Maximum 20 data records/file, 256 KiB/file and 100 total records.
- Existing 17 fields plus only COL_003–005, maximum 20.
- COL_006/007 remain HOLD; COL_008/009 remain EXCLUDE.
- Context-aware VERSION/schema/data detection; credential controls unchanged.
- No raw row, full path, rejected raw value, unapproved value, source modification, network/DB/PLC/OPC, DAT/XLSX/XML/HISTO access.

A future pilot compares the four exact candidate tuples and finds the shortest conflict-free combination while retaining source/schema/record provenance. State promotion is capped at STRUCTURALLY_VALIDATED. CONFIRMED is prohibited without official evidence or separate onsite validation.

This package authorizes nothing by itself: Collector implementation, nonProduction execution and Production execution each remain separately gated.
