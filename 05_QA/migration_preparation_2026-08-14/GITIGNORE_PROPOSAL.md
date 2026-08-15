# .gitignore Proposal

Status: proposal only; .gitignore was not changed.

## Proposed rules

    /02. Project Backup/
    /UtilityAI_FieldData/
    /FieldData/
    /Production_Evidence/
    /usb/
    **/Output/
    **/Output_*/
    **/Sample_Output/
    **/Pilot_Output/
    **/*_Collection_Output/
    **/release_recheck/
    **/*release_recheck*/
    **/debugout/
    **/direct-after-rebuild/
    /05_QA/generated/
    /07_Release/packages/
    PCVue_Collection_*.zip*
    PCVue_CSV_Header_Sample_*.zip*
    PCVue_VAREXP_*_Pilot_*.zip*
    *.tmp
    *.temp
    *.cache
    .DS_Store
    Thumbs.db
    desktop.ini
    /.codex-write-test.txt

Do not ignore all CSV, MD, SHA256, 05_QA or 07_Release files. Source matrices, durable QA reports, design decisions, synthetic fixtures and release manifests/checksums must remain visible.

Before application, test representative paths with git check-ignore, assert approved durable files remain visible, assert FieldData/generated paths become ignored, compare status counts, then run secret and forbidden-path scans. Release ZIPs should normally be private GitHub Release assets; checksum and manifest stay tracked.
