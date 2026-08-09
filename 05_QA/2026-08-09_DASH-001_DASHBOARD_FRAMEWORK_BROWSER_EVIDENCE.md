# DASH-001 — Dashboard Framework Browser Evidence

| Field | Value |
|---|---|
| Status | Review |
| Date | 2026-08-09 |
| Browser | Codex in-app Chromium browser |
| Fixture | `tests/Fixtures/DashboardFramework` |
| Result | PASS FOR DRAFT REVIEW |

## Multilingual Evidence

| Locale/layout | Observed result | Screenshot | Status |
|---|---|---|---|
| `ko-KR` desktop, 1440 × 1000 | Korean title, navigation, states, failure, table, date, number, Unicode glyphs, and selected locale exposed; page overflow false | [Korean desktop](evidence/DASH-001/dashboard-framework-ko-KR-desktop.jpg) | PASS |
| `vi-VN` desktop, 1440 × 1000 | Vietnamese diacritics, expanded labels, localized number/date, selected locale, and failure isolation visible; page overflow false | [Vietnamese desktop](evidence/DASH-001/dashboard-framework-vi-VN-desktop.jpg) | PASS |
| `en-US` desktop, 1440 × 1000 | Canonical English fallback presentation, shell, regions, states, formatting, and isolated error visible; page overflow false | [English desktop](evidence/DASH-001/dashboard-framework-en-US-desktop.jpg) | PASS |
| `ko-KR` mobile, 375 × 900 | Compact menu is initially collapsed, primary content begins immediately after the 44px menu control, Korean labels wrap safely, and page overflow is false | [Korean mobile](evidence/DASH-001/dashboard-framework-ko-KR-mobile.jpg) | PASS |
| `en-US` mobile, 375 × 900 | Compact menu is initially collapsed, primary content begins immediately after the 44px menu control, and page overflow is false | [English mobile](evidence/DASH-001/dashboard-framework-en-US-mobile.jpg) | PASS |

## CTO-requested Experience Shell Refinement

- The desktop navigation is a compact 12.5rem rail with grouped Platform and Operations fixture destinations, consistent 44px targets, and explicit active/inactive hierarchy.
- The header provides non-operational site, simulated system state, future notifications, and future account placeholders while retaining the global language selector on the right.
- The content canvas uses a denser, aligned responsive grid without production KPIs, alarms, or utility-specific data.
- At 375 × 900, the navigation is hidden initially. The 44px menu control changes `aria-expanded` from `false` to `true`, reveals the controlled navigation, and returns to the collapsed state without page overflow.

## Interaction and Responsive Evidence

- `lang` updated to `ko-KR`, `vi-VN`, and `en-US` with the matching selector button `aria-pressed="true"`.
- Stored `vi-VN` preference survived a browser reload and restored the correct document language and selected button.
- At 320, 375, 768, 1024, 1440, 1920, and 2560 CSS pixels, page-level overflow was false and every visible language button met the 44 × 44 CSS-pixel minimum.
- Accessibility snapshot exposed a banner, named language group, named primary navigation, one main landmark, ordered headings/regions, truthful status text, captioned table with row/column headers, alert, and contentinfo.
- The simulated renderer failure remained local to one widget; the shell and three successful content regions remained visible.

## Zoom, Reflow, and Deferred Limitations

- Browser zoom commands were issued from the in-app browser, but the fixture viewport, `devicePixelRatio`, and visual viewport scale did not change. Consequently, actual 200% browser zoom could not be verified in this environment and is recorded as **NOT VERIFIED**, not PASS.
- The 320 CSS-pixel responsive run provides applicable narrow-width reflow evidence with no page-level horizontal scrolling, but it is not represented as an actual 400% browser-zoom PASS. Actual 400% reflow remains **NOT VERIFIED**.
- VoiceOver, forced-colors/high-contrast, and active OS reduced-motion remain **NOT RUN / Deferred** as previously permitted. They are not represented as PASS.
