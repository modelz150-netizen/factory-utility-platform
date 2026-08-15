# .gitignore Final Proposal

Status: final proposal only; not applied.

    # Production/OT/FieldData
    /02. Project Backup/
    /UtilityAI_FieldData/
    /FieldData/
    /Production_Evidence/
    /usb/

    # Collector runtime output
    **/Output/
    **/Output_*/
    **/Sample_Output/
    **/Pilot_Output/
    **/*_Collection_Output/

    # Local extraction and repeated validation
    **/release_recheck/
    **/*release_recheck*/
    **/debugout/
    **/direct-after-rebuild/
    /05_QA/generated/
    /07_Release/packages/

    # Raw collection products
    PCVue_Collection_*.zip
    PCVue_Collection_*.zip.sha256
    PCVue_CSV_Header_Sample_*.zip
    PCVue_CSV_Header_Sample_*.zip.sha256
    PCVue_VAREXP_*_Pilot_*.zip
    PCVue_VAREXP_*_Pilot_*.zip.sha256

    # Cache/temp/OS
    *.tmp
    *.temp
    *.cache
    .DS_Store
    Thumbs.db
    desktop.ini
    /.codex-write-test.txt

Never add blanket rules for 00_Governance, 03_Development, 04_Design, 05_QA, 07_Release, CSV, Markdown, JSON, PSD1, SHA256 or all ZIP sidecars. Those would hide source, architecture, design Gates, durable QA, safe synthetic fixtures, contracts or release integrity records.

Before applying, validate with git check-ignore -v against positive and negative path fixtures. Require all 182 TRACK_IN_GIT candidates to remain visible and all 3,618 FieldData plus 347 generated candidates to be excluded or externally relocated as designed.
