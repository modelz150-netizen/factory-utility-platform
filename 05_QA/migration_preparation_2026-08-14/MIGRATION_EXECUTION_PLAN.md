# Migration Execution Plan

| Field | Value |
|---|---|
| Status | Draft; execution not authorized |
| Strategy | B |
| Final Gate | **MIGRATION_EXECUTION_READY = NO** |

## Blockers

- .gitignore proposal not approved/applied.
- UtilityAI_FieldData not created.
- 210 files remain MANUAL_REVIEW.
- Three Governance modifications need human review.
- Synthetic fixture provenance/minimum set not finalized.
- Binary release publication policy not operational.
- Project Backup Manifest lacks independent recheck.

## Future sequence

1. Approve the exact ignore and FieldData policies.
2. Re-run inventory and explain drift from the 4,149-file baseline.
3. Create restricted UtilityAI_FieldData outside all repositories.
4. Recompute and compare the source Manifest.
5. Copy Project Backup; retain source.
6. Verify destination: files 3,601, directories 535, bytes 401,246,873, SHA 100%, missing/additional 0.
7. Obtain separate approval before source removal.
8. Move USB staging under separate Manifest control.
9. Apply ignore rules on a migration branch.
10. Review 89 TRACK_IN_GIT and 210 MANUAL_REVIEW files.
11. Run secret, OT-path, large-file, duplicate and staged-content scans.
12. Prepare small category commits only after authorization.
13. Validate clean Windows/Mac clones with synthetic data.
14. Push only through the approved Private GitHub PR process.

## Classification baseline

| Classification | Files | Bytes |
|---|---:|---:|
| TRACK_IN_GIT | 89 | 367,684 |
| MOVE_TO_FIELDDATA | 3,618 | 401,405,178 |
| IGNORE_GENERATED | 231 | 2,090,114 |
| DELETE_CANDIDATE | 1 | 25 |
| MANUAL_REVIEW | 210 | 1,835,742 |
| Total | 4,149 | 405,698,743 |

CURRENT_STATE = 3 modified tracked and 4,149 baseline untracked before this Gate's outputs  
RISKS = OT backup proximity, ineffective ignore, manual-review backlog and generated duplication  
KEEP = canonical source, Governance/Architecture, design decisions, durable QA, reviewed synthetic fixtures, checksums/manifests  
MOVE_LATER = Project Backup and USB staging after checksum Gate  
IGNORE = generated output, extracted rechecks, caches and expanded packages  
DELETE_CANDIDATE = .codex-write-test.txt only; no deletion authorized  
REPOSITORY_STRATEGY_RECOMMENDATION = B  
MIGRATION_EXECUTION_READY = NO
