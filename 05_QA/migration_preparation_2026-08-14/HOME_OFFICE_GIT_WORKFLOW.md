# Home–Office Git Workflow

GitHub Private is the Source of Truth for source and durable sanitized artifacts. FieldData is excluded.

1. Confirm the worktree and active task.
2. Pull only after confirming no uncommitted handoff.
3. Use one task branch owned by one active device at a time.
4. Work with synthetic/nonProduction data only.
5. Run QA, secret scan, forbidden-path scan and status review.
6. Review the exact staged list; never blanket-stage near FieldData.
7. Commit a scoped change, push the task branch and use a pull request.
8. Before changing device, commit/push intended work and leave a clean handoff.

Do not edit the same branch concurrently on company Windows and home MacBook. Device A must stop and push before Device B pulls. Do not transfer uncommitted work by cloud-drive ZIP. Use separate SSH keys, MFA and OS credential stores. Add line-ending policy later. Machine-local configuration remains ignored with placeholder examples tracked.

UtilityAI_FieldData is not synced through GitHub or consumer cloud. Site transfer requires separately approved encryption, manifest and access records.
