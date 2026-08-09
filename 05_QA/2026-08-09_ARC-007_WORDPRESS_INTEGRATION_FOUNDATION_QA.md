# ARC-007 WordPress Integration Foundation QA

| Field | Value |
|---|---|
| Date | 2026-08-09 |
| Status | APPROVED |
| Deliverable | WordPress Integration Foundation — Active / Approved / 1.0.0 |
| Pull request | PR #46 |
| Approval | Final CTO + Utility Manager Visual Approval — 2026-08-09 |
| Runtime | Official WordPress Playground CLI, latest WordPress resolved at execution, PHP 8.3, SQLite test runtime |

## Implemented boundary

- versioned plugin entry and the existing single composition root;
- safe activation/deactivation hooks and non-destructive uninstall;
- canonical `/factory-utility/` rewrite plus `factory_utility_route=home` query fallback;
- authenticated, deny-by-default `view_factory_utility_dashboard` enforcement before projection/fixture delivery;
- development/staging fixture delivery with visible simulation disclosure;
- production fixture fail-closed response;
- WordPress admin launcher and non-sensitive version/environment/route/fixture status;
- `ko-KR`, `vi-VN`, and `en-US` Home Dashboard delivery through approved assets;
- version/build manifest and reproducible QA ZIP packaging without development dependencies.

No role receives the application capability from plugin activation. The disposable QA blueprint grants the capability explicitly to the temporary administrator for authorized-route testing.

## Automated validation

| Validation | Result |
|---|---|
| Composer strict and token check | PASS |
| PHPStan maximum configured level | PASS — 0 errors |
| PHPUnit | PASS — 107 tests / 600 assertions |
| WordPress adapter dependency fitness | PASS |
| Route/capability/environment contract tests | PASS |
| PHP syntax and WordPress entry smoke | PASS |
| Composer security audit | PASS — 0 advisories |
| Markdown internal links | PASS — 0 broken |
| ZIP integrity and SHA-256 verification | PASS |
| Development dependencies excluded from ZIP | PASS |

## Actual WordPress integration evidence

| Required evidence | Result |
|---|---|
| [Plugin activation screen](evidence/ARC-007-wordpress-plugin-activation.png) | PASS — plugin active in WordPress Plugins UI; Factory Utility admin entry visible |
| [WordPress Admin launcher](evidence/ARC-007-wordpress-admin-launcher.png) | PASS — Version 1.0.0, development environment, route and fixture policy shown |
| [`/factory-utility/` Korean desktop](evidence/ARC-007-wordpress-home-ko-KR-desktop.png) | PASS — authenticated WordPress canonical route |
| [`/factory-utility/` Vietnamese desktop](evidence/ARC-007-wordpress-home-vi-VN-desktop.png) | PASS |
| [`/factory-utility/` English desktop](evidence/ARC-007-wordpress-home-en-US-desktop.png) | PASS |
| [Korean mobile](evidence/ARC-007-wordpress-home-ko-KR-mobile.png) | PASS — global overflow 0 |
| [Unauthorized access](evidence/ARC-007-wordpress-unauthorized.png) | PASS — safe authentication-required response; no projection exposed |
| [Production fixture fail-closed](evidence/ARC-007-wordpress-production-fail-closed.png) | PASS — HTTP application response states no simulated data was loaded |

Canonical pretty route and query fallback both rendered the same authorized Home Dashboard. The route retained `SIMULATED / FIXTURE`, plant timezone, truthful states, failure-isolation fixture selection, and three-locale behavior.

## Installable QA artifact

- [factory-utility-platform-1.0.0-qa.zip](artifacts/ARC-007/factory-utility-platform-1.0.0-qa.zip)
- [SHA-256](artifacts/ARC-007/factory-utility-platform-1.0.0-qa.zip.sha256)

The QA ZIP is installable and contains the approved non-production Home Dashboard review fixture. It is not a production deployment package or authorization. Production fixture selection remains prohibited and fail-closed. A future production build profile must exclude the review fixture.

## Security and lifecycle findings

- Authentication and capability checks occur before fixture/environment delivery.
- Unknown environments normalize to production fail-closed behavior.
- No default role/capability assignment is introduced.
- No database schema, post, page, user, role, schedule, external request, or operational data is created.
- Deactivation retains state and only refreshes routing.
- Uninstall is intentionally non-destructive.
- User-facing failures expose no stack trace, path, credential, or provider endpoint.

## Limitations

- Actual 200% zoom and applicable 400% reflow: NOT RUN / Deferred.
- VoiceOver: NOT RUN / Deferred.
- OS/browser forced-colors/high-contrast: NOT RUN / Deferred.
- OS reduced-motion: NOT RUN / Deferred.
- Production deployment: NOT RUN / prohibited by scope.
- MySQL/MariaDB compatibility: NOT RUN; the disposable WordPress evidence runtime used SQLite.

Unexecuted checks are not represented as PASS.

## Scope and approval gate

- Live SCADA/BMS/FMS, alarm/KPI sources, production data, database schema, external authentication, AI/Gemma, CMMS/workflow, notifications, controls, detailed Utility screens, and production deployment: absent.
- Critical issues: 0.
- Major issues: 0.
- Final CTO and Utility Manager visual and integration review: APPROVED.
- PR #46 is authorized for Ready transition and merge with no additional functionality.
