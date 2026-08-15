# Field Data External Storage Plan

| Field | Value |
|---|---|
| Status | Proposed; target not created |
| Strategy | B |
| Target root | C:\Users\405880\Documents\Codex\UtilityAI_FieldData |

Target folders: PCVue_Production, PCVue_Collection, PLC_HMI_Backup, Alarm_Trend_Export, Field_Evidence, USB_Staging.

Planned move: factory-utility-platform\02. Project Backup → UtilityAI_FieldData\PLC_HMI_Backup\02. Project Backup. No folder creation, copy or move occurred.

## Pre-migration baseline

| Metric | Value |
|---|---:|
| File count | 3,601 |
| Directory count excluding root | 535 |
| Total bytes | 401,246,873 |
| Manifest SHA-256 | 5D974EFB70F4F66897010031033D506A155D7C44B05B96785DEEA012B7358DAE |

Future destination validation requires identical relative-path sets, FileCount 3,601, DirectoryCount 535, TotalBytes 401,246,873, SHA-256 match 100%, missing 0 and additional 0. Reparse/network paths are prohibited. Use copy → verify → separately approve source removal, not an unverified move.

FieldData must use restricted permissions, encrypted backup, opaque evidence IDs, source/capture metadata, checksums, retention and access records. It must remain outside GitHub and consumer cloud sync.
