# VAREXP Pilot Scope

## Approved candidate source scope

The proposed Pilot is limited to the five VAREXP files already validated in Production by RC5:

1. USR\SSV Integrated Project\C1\Shared\varexp_main.csv
2. USR\SSV Integrated Project\C1\Shared\A\varexp\plc_m_varexp.csv
3. USR\SSV Integrated Project\C1\Shared\B\varexp\G03_varexp.csv
4. USR\SSV Integrated Project\C1\Shared\C\varexp\BFU_varexp.csv
5. USR\SSV Integrated Project\C1\Shared\ELEC\varexp\E02_varexp.csv

The remaining 34 VAREXP candidates are outside scope. Wildcard discovery and automatic expansion are prohibited.

## Proposed Pilot ceilings

- Five files maximum.
- 100 data logical records per file maximum.
- 1 MiB data-row bytes per file maximum.
- 500 emitted rows maximum across the Pilot.
- 42 approved positional value fields maximum per emitted row.
- Schema mismatch or field count other than 262: immediate file stop.

## Required preconditions before implementation

- Manual approval of the 42-field allowlist.
- Manual approval of the 100-record/1-MiB ceilings.
- Security review of result handling for Tagname and Description.
- NonProduction fixture validation for data-row non-leakage, excluded-field non-leakage, and exact positional binding.
- Windows PowerShell 5.1 static/security and complete E2E validation.
- Separate Production execution approval after implementation validation.

## Exclusions

- QUALIFIER_VARIANT columns 3–9.
- All 85 RESERVED_CANDIDATE_UNCONFIRMED positions.
- All EXCLUDED_SENSITIVE fields.
- HISTO, DAT, XLSX, XML, native formats, PLC, OPC, DB, and network access.
- Source modifications, service/process control, and privilege elevation.

## Current status

Production data rows were not accessed. No Collector was implemented. PvTrend remains APPROVED_STRUCTURE without a data-row collector. HISTO remains MANUAL_FORMAT_REVIEW_REQUIRED.

**Pilot recommendation: MANUAL_FIELD_REVIEW_REQUIRED**
