# Release Artifact Policy

| Artifact | Git repository | Private GitHub Release |
|---|---|---|
| Canonical source/configuration | Track | No |
| Release manifest | Track | Optional attachment |
| SHA-256 sidecar | Track | Attach with binary |
| Release note/change report | Track | Publish summary |
| Binary ZIP | Do not repeatedly commit | Primary approved location |
| Expanded/recheck package | Ignore | No |
| USB staging copy | External FieldData | No |

Every release manifest must record component/version, source commit, build procedure, toolchain, QA reports, authorization state, artifact filename, size and SHA-256. A binary is uploaded only after explicit release approval. GitHub Release remains Private and uses an annotated component tag.

Current ZIP files are not uploaded, moved or deleted by this policy. They are classified as generated/local binary artifacts pending a later execution and publication decision.
