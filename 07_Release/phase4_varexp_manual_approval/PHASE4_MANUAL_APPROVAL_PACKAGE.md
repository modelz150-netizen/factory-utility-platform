# Phase 4 Manual Approval Package

## Decision requested from user

Approve or reject the proposed 17-field allowlist and reduced first-Pilot read boundary. No implementation or Production execution has occurred.

## Manual field review outcome

| Recommendation | Count | Treatment |
|---|---:|---|
| APPROVE | 17 | Proposed value-output allowlist |
| METADATA_ONLY | 8 | Do not emit data-row values |
| EXCLUDE | 17 | Do not emit or log values |
| Total reviewed | 42 | Complete |

The reduction removes threshold, range, scaling, control, and initial-value settings from the first Pilot. It retains only Tag identity, descriptions, classification, basic state, logging/historian indicators, basic alarm identity, engineering unit, and format. Communication/address fields remain excluded by the Phase 4 sensitive-field policy.

## Proposed first Pilot

- Five already validated VAREXP source files.
- Maximum 20 data logical records per file.
- Maximum 256 KiB data-row bytes per file.
- Maximum 100 emitted rows.
- Exactly 17 allowlisted positional value fields.
- Source-specific OriginalHeader and positional provenance retained.

## Why five files remain

All five are required to verify the two observed schema-placement patterns and source-specific header variants. Reducing records per file provides a materially smaller data footprint while preserving cross-file validation.

## Preconditions after user approval

User approval authorizes only a subsequent implementation task. The implementation must still pass static/security validation, Windows PowerShell 5.1 fixtures and complete E2E, sentinel non-leakage tests, source immutability tests, ZIP integrity checks, and then stop for a separate Production execution approval.

## Unchanged exclusions

- QUALIFIER_VARIANT 7 fields.
- RESERVED_CANDIDATE_UNCONFIRMED 85 fields.
- All communication, address, endpoint, credential, and remote-connection fields.
- HISTO content and parser.
- PvTrend data rows.
- DAT/XLSX/XML/native content.
- Network, PLC, OPC, and DB access.

## Gate recommendation

**READY_FOR_USER_APPROVAL**

This means the approval package is ready for a human decision. It does not mean the Collector or Production run is approved.
