# UtilityAI Repository Relationship

| Item | Finding |
|---|---|
| Separate UtilityAI Git repository | NOT FOUND |
| UtilityAI-named directory | NOT FOUND |
| Search scope | Documents, Desktop and Downloads; bounded directory traversal |
| Other unrelated Git repositories found | Two repositories under Downloads |
| Current relationship | UtilityAI concepts exist in Factory Utility Platform design documents, but no independent repository was located |

## Structure options

| Option | Advantages | Disadvantages | Assessment |
|---|---|---|---|
| A. Monorepo | Atomic schema/API changes; single CI and issue history | Strong risk of mixing app source, AI artifacts and OT evidence; larger permissions/blast radius | Not recommended now |
| B. factory-utility-platform + UtilityAI separate private repositories | Independent access, release cadence, model/data governance and smaller blast radius | Requires versioned contracts and coordinated releases | Recommended |
| C. Master/meta repository plus independent component repositories | Clear portfolio map and pinned component versions | More operational overhead; submodule/manifest complexity | Consider later when multiple components are stable |

## Recommended relationship

Keep Factory Utility Platform as the product/application repository. Create UtilityAI later as a separate private repository containing AI service source, evaluation code and synthetic schemas only. Exchange data through versioned contracts; keep Production OT datasets in neither repository. A lightweight master manifest may be introduced later, but is premature now.
