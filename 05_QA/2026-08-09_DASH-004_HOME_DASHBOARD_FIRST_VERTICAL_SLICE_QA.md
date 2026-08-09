# DASH-004 Home Dashboard First Vertical Slice QA

| Field | Value |
|---|---|
| Date | 2026-08-09 |
| Status | PASS FOR CTO + UTILITY MANAGER VISUAL REVIEW |
| Scope | Simulated Home Dashboard first vertical slice |
| Approval state | Draft implementation; not approved for merge |

## Implemented boundary

- `overall-health/1.0` fail-safe Domain policy and immutable projection
- Application Home Dashboard read port and composite projection
- isolated deterministic fixture adapter with the approved named scenario catalogue
- Experience-only manager dashboard fixture using the approved Design System and Dashboard Framework assets
- Overall Health, alarm summary, supplied-priority attention, eight Utility cards, four P0 KPIs, reliability risk, maintenance, and subordinate P1 context
- `ko-KR`, `vi-VN`, and `en-US`; plant-local time; visible simulation/freshness/provenance cues
- responsive mobile/desktop layout and contained widget/source failure presentation

## Automated validation

| Validation | Result |
|---|---|
| Composer strict and token check | PASS |
| PHPStan maximum configured level | PASS — 0 errors |
| PHPUnit | PASS — 88 tests / 556 assertions |
| Fail-safe precedence tests | PASS |
| Fixture/read-port contracts | PASS |
| Dependency architecture fitness | PASS |
| CSS/JavaScript asset budgets | PASS |
| External connection/production registration prohibition | PASS |

## Browser evidence

| Evidence | Result |
|---|---|
| [Korean desktop — abnormal/critical](evidence/DASH-004/home-dashboard-ko-KR-desktop.png) | PASS — captured at desktop viewport |
| [Vietnamese desktop](evidence/DASH-004/home-dashboard-vi-VN-desktop.png) | PASS — captured at desktop viewport |
| [English desktop](evidence/DASH-004/home-dashboard-en-US-desktop.png) | PASS — captured at desktop viewport |
| [Korean mobile](evidence/DASH-004/home-dashboard-ko-KR-mobile.png) | PASS — captured at narrow viewport |
| [English mobile](evidence/DASH-004/home-dashboard-en-US-mobile.png) | PASS — captured at narrow viewport; global overflow 0 |
| [Partial/stale/unavailable](evidence/DASH-004/home-dashboard-partial-stale-unavailable.png) | PASS — truth states remain explicit |
| [Widget/source failure](evidence/DASH-004/home-dashboard-widget-source-failure.png) | PASS — attention-source failure is contained and other widgets remain visible |

## Accessibility evidence

- semantic landmarks, headings, region labels, native select, locale buttons, skip link, and compact navigation are present;
- interactive controls inherit the approved minimum 44 by 44 CSS-pixel targets and visible focus treatment;
- Critical and Warning use text labels and structural borders in addition to color;
- forced-colors and reduced-motion rules are present;
- actual manual 200% zoom: NOT RUN / Deferred for final visual review;
- applicable actual 400% reflow: NOT RUN / Deferred for final visual review;
- VoiceOver: NOT RUN / Deferred;
- OS/browser forced-colors or high contrast: NOT RUN / Deferred;
- OS reduced-motion: NOT RUN / Deferred.

Unexecuted checks are not represented as PASS.

## Scope exclusions

No live SCADA/BMS/FMS, real alarm evaluation, real KPI formula, production data, database, authentication, AI/Gemma, CMMS/workflow, notification, control command, Utility detail screen, or production deployment was introduced.

## Findings and gate

- Critical issues: 0
- Major issues: 0
- Draft PR must remain Draft after automated validation.
- CTO and Utility Manager visual review is required before Ready or merge.
