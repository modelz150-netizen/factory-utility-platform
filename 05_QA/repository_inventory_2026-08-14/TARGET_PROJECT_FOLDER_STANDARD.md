# Target Project Folder Standard

| Path | Purpose | Git policy |
|---|---|---|
| 00_Governance | Charter, standards, ADRs, backlog/status | Track |
| 01_Product | Requirements and acceptance criteria | Track |
| 02_Engineering | Formulas, domain definitions, sanitized references | Track reviewed material only |
| 03_Development | Source, architecture and developer tooling | Track source; exclude runtime output |
| 04_Design | Design system and UX assets | Track |
| 05_QA/plans | Test strategy/cases | Track |
| 05_QA/fixtures/synthetic | Small synthetic fixtures | Track |
| 05_QA/reports | Durable summarized results | Track |
| 05_QA/generated | Raw test runs, extracted ZIPs, screenshots not selected as evidence | Ignore |
| 07_Release/manifests | Release notes, checksum manifest, rollback | Track |
| 07_Release/packages | Local binary packages | Ignore; publish through private GitHub Release after approval |
| 99_Knowledge | Sanitized research and imported knowledge | Track after review |
| local/production-evidence | Production/OT evidence | Outside repository; encrypted governed storage |
| local/usb-staging | Deployment staging | Outside repository/ignored |

## Proposed .gitignore additions

This is a proposal only; .gitignore was not changed.

- /02. Project Backup/
- /usb/
- /.codex-write-test.txt
- **/Pilot_Output/
- **/Sample_Output/
- /05_QA/**/Output*/
- /05_QA/**/Project Files/
- /05_QA/**/release_recheck/
- /05_QA/generated/
- /07_Release/packages/
- PCVue_Collection_*.zip*
- PCVue_CSV_Header_Sample_*.zip*
- PCVue_VAREXP_*_Pilot_*.zip*
- *.tmp, *.bak, desktop.ini, .DS_Store

Use explicit negative exceptions only for reviewed synthetic fixtures and durable reports.

## Production evidence standard

Production evidence must live outside Git in an encrypted, access-controlled store. Each case uses an opaque evidence ID, classification, source system, capture date, collector version, SHA-256, retention period and approval record. Reports refer to the evidence ID rather than full local paths or raw values.
