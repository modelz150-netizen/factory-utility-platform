# Git Worktree Analysis

| Item | Result |
|---|---|
| Repository root | C:\Users\405880\Documents\Codex\factory-utility-platform |
| Branch | main |
| HEAD | f5786b5a53d4c273a813c312e508f6c4f5e2d6ef |
| Message | Merge pull request #46 from modelz150-netizen/agent/wordpress-integration-foundation |
| Commit timestamp | 2026-08-09T15:44:07+07:00 |
| Remote | origin = https://github.com/modelz150-netizen/factory-utility-platform.git |
| Upstream | origin/main |
| Tracked files | 215 |
| Modified | 3 |
| Deleted | 0 |
| Untracked | 4,142 |
| Ignored | 0 |
| Total status entries | 4,145 |
| Stash | none |
| Local branches | main only |
| Tags | v1.0.0 |
| main vs cached origin/main | 0 ahead / 0 behind |

No fetch was run. Ahead/behind is based on the locally cached origin/main ref and does not establish current GitHub state.

## Modified tracked files

- 00_Governance/AI_STATUS.md
- 00_Governance/BACKLOG.md
- 00_Governance/CHANGELOG.md

## Dirty worktree causes

| Category | Count | Disposition proposal |
|---|---:|---|
| Backup/Field Evidence Candidate | 3,601 | Never bulk-add; move later to governed evidence storage |
| QA Generated Output | 156 | Ignore; retain only selected report/manifest |
| Fixture/Test Data | 135 | Track synthetic minimal fixtures only |
| QA Result/Report | 125 | Review and track durable reports; ignore raw reruns |
| Release Result | 84 | Track manifests/reports; publish ZIP assets separately |
| New Development Artifact | 23 | Review Collector source for intentional commit |
| Generated Output in Source Tree | 16 | Ignore and keep outside source directory |
| Normal tracked modifications | 3 | Human review before future commit |
| New Documentation/Design | 1 | Review |
| Cache/Temporary | 1 | Ignore/delete candidate after approval |

## .gitignore finding

Current content excludes only .tools/. Consequently there is no protection for OT backups, generated Collector output, QA run folders, local ZIPs, USB staging or temporary files.

## Recent history

1. f5786b5 Merge PR #46 — WordPress integration foundation
2. 560d1d6 Record PR #46 final approval
3. 5ec43e2 Link ARC-007 draft PR
4. 55932c8 Implement WordPress integration foundation
5. ac8045e Merge PR #45 — WordPress integration plan
6. 0d8e586 Record ARC-006 approval
7. caff6f5 Link ARC-006 draft PR
8. 9742e64 Plan WordPress integration
9. 87ced2d Merge PR #44 — Home Dashboard vertical slice
10. 8d9ac23 Record DASH-004 final approval

## Risk conclusion

A blanket git add is unsafe. Most worktree entries are untracked OT/backup or generated evidence rather than ordinary source changes.
