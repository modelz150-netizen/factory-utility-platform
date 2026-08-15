# Migration Plan Draft

| Field | Value |
|---|---|
| Status | Draft — no migration authorized |
| Recommendation | Separate private repositories (Option B) |
| Migration ready | NO |

## Proposed gates

1. Freeze writes briefly and capture a fresh read-only inventory.
2. Human-review the three modified Governance files.
3. Approve deny-by-default .gitignore and Production evidence policy.
4. Classify 02. Project Backup outside Git; create hashes and an evidence index without raw values.
5. Separate synthetic fixtures from generated QA output.
6. Select authoritative Phase 3–4.2 source, design, QA report and release-manifest copies.
7. Identify duplicate/recheck/output copies as retention or deletion candidates; do not delete without approval.
8. Run secret, OT path, large-file and staged-content scans.
9. Prepare small reviewable commits by category on a migration branch.
10. Establish GitHub Private protections, required checks and machine setup documentation.
11. Validate a clean clone on company Windows and home MacBook using synthetic data only.
12. Create UtilityAI separately only when its scope, interface and governance are approved.

## Company ↔ home development requirements

- GitHub Private with MFA, branch protection and least-privilege collaborators.
- Separate SSH keys per device; no shared private key.
- OS credential manager for tokens.
- LF text normalization through .gitattributes; PowerShell scripts tested with Windows-compatible handling.
- No absolute local paths in tracked configuration.
- Machine-local .env/local config ignored; committed example files contain placeholders only.
- Release and QA commands reproducible from a clean clone.
- Production evidence never synchronized through GitHub.

## Final summary

CURRENT_STATE = main at f5786b5; 215 tracked; 3 modified; 4,142 untracked; 0 ignored; 4,145 status entries; cached origin/main 0/0  
RISKS = 3,601 untracked backup/field-evidence files; ineffective gitignore; generated QA/Release duplication; possible OT network/tag/alarm material  
KEEP = governed source, architecture, design, durable QA reports, synthetic minimal fixtures, release manifests/checksums  
MOVE_LATER = 02. Project Backup, Production evidence, USB staging, local release binaries, raw QA run evidence  
IGNORE = generated Output/Sample_Output/Pilot_Output, extracted release rechecks, local packages, caches and OS files  
DELETE_CANDIDATE = workspace probe, redundant generated runs, duplicate package copies and hash-identical backups; approval required  
REPOSITORY_STRATEGY_RECOMMENDATION = B — factory-utility-platform and future UtilityAI as separate private repositories with versioned contracts  
MIGRATION_READY = NO
