# PCVue VAREXP Format Evidence

## Question

Does an authoritative PCVue 16.2 / ARC Informatique specification confirm a 262-column VAREXP layout and identify the 85 empty positions as reserved or unused?

## Local evidence

No approved local vendor manual, installed-help export specification, schema dictionary, or VAREXP field map was found in the workspace evidence used for this Gate. Production SCADA and its installed documentation were not accessed.

## Official public-source search

The search was restricted to official ARC Informatique and PcVue Solutions domains.

- ARC Informatique publishes a PcVue ProductHelp site, demonstrating that official online product documentation exists: https://www.arcinfo.com/ProductHelp/PcVue/en/
- The official PcVue download instructions state that the full PcVue package includes documentation and help: https://www.pcvuesolutions.com/wp-content/uploads/2024/06/Download-instructions-PcVue-English.pdf
- Searches of the public official documentation for VAREXP, variable export/import CSV format, a 262-column definition, and reserved/unused positional fields did not locate an applicable PCVue 16.2 format specification.
- General official pages describing data export do not define the VAREXP variable schema: https://www.pcvuesolutions.com/data-processing-and-reporting/

No large installer or documentation package was downloaded.

## Evidence assessment

| Evidence question | Result |
|---|---|
| Official documentation platform exists | Confirmed |
| Official PCVue package is described as including help/documentation | Confirmed |
| Public PCVue 16.2 VAREXP 262-column schema located | Not found |
| Official reserved/unused mapping for the 85 empty positions located | Not found |
| Empty positions may be declared reserved from official evidence | No |

The absence of a publicly located specification is not proof that no vendor or installed documentation exists. It means this Gate has no authoritative basis to label the empty positions as confirmed reserved/unused fields.

## Required evidence for reconsideration

A later Gate may reconsider the result if supplied with an applicable PCVue 16.2 vendor export/import specification, installed help page, schema/data dictionary, or written ARC Informatique confirmation mapping the VAREXP positions. Until then, the empty positions remain ReservedCandidate only.
