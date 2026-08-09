# DES-001 — Design System Foundation Accessibility Evidence

| Field | Value |
|---|---|
| Status | Review |
| Date | 2026-08-09 |
| Target | WCAG 2.2 Level AA |
| Browser | Codex in-app Chromium browser |
| Fixture | Non-production Design System fixture |
| Result | PASS WITH DEFERRED LIMITATIONS — FINAL CTO REVIEW |

## Executed Evidence

| Check | Method and observed result | Status |
|---|---|---|
| Semantic structure | Browser accessibility snapshot exposed banner, named navigation, one main landmark, regions, heading hierarchy, labeled textbox, buttons, captioned table with headers, dialog, and contentinfo | PASS |
| Automated contract scan | DOM scan found 0 unlabeled interactive controls, 0 duplicate IDs, 0 images without alt, one H1, one main, and a document language | PASS |
| Keyboard dialog | Unique Open dialog control opened the native modal; focus moved to Close dialog; Escape closed it; focus returned to `open-dialog` | PASS |
| Focus contract | Shared three-pixel `:focus-visible` tokenized outline with offset; no positive tabindex | PASS |
| Interaction target | Every visible button measured at least 44 × 44 CSS pixels at each evidence width | PASS |
| Responsive/reflow | 320, 375, 768, 1024, 1440, 1920, and 2560 CSS-pixel widths had no page-level horizontal overflow | PASS |
| 200% text resize | Manual Mac browser review found no lost content or controls and no visual Critical or Major defect | PASS |
| Applicable 400% reflow | Manual Mac browser review found the fixture usable without prohibited page-level horizontal scrolling and no visual Critical or Major defect | PASS |
| Reduced motion | CSS contract is automated; actual OS preference validation was not run | DEFERRED |
| Forced colors/high contrast | CSS contract is automated; actual OS/browser mode validation was not run | DEFERRED |
| Screen reader | Automated semantic snapshot passed; actual macOS VoiceOver validation was not run | DEFERRED |

Automated evidence supplements rather than replaces manual review. No WCAG Critical or Serious issue was observed in the executed contract scan. Deferred checks remain limitations and are not represented as PASS.

## CTO Conditional Validation Attempt — 2026-08-09

The fixture was reopened in the connected Codex in-app Chromium browser at a controlled 1280 × 900 viewport. Browser zoom shortcuts were issued from a reset state, but the controlled browser retained an `innerWidth` of 1280 CSS pixels and exposed no observable zoom state. The result therefore cannot substantiate actual 200% browser zoom and is recorded as unavailable, not PASS.

The connected browser exposes viewport control but no forced-colors, contrast-preference, reduced-motion, or browser-zoom emulation capability. Source rules and the 320 CSS-pixel reflow equivalent remain verified, but actual OS/browser preference validation is still required.

No controllable macOS VoiceOver session, speech output capture, rotor state, or VoiceOver cursor inspection is available in the current validation surface. The browser accessibility tree is not represented as a substitute for the required actual VoiceOver review.

The subsequent manual Mac browser review supplied for final PR preparation supersedes only the earlier unavailable dispositions for actual 200% zoom and applicable 400% reflow. It does not change the remaining deferred checks.

| Outstanding check | Current disposition | Completion evidence required |
|---|---|---|
| Actual 200% browser zoom | PASS — manual Mac browser review | No content or controls lost; no visual Critical or Major defect identified |
| Actual applicable 400% reflow | PASS — manual Mac browser review | Usable without prohibited page-level horizontal scrolling; no visual Critical or Major defect identified |
| macOS VoiceOver | NOT RUN / DEFERRED | Navigation, button, form, status, table, dialog, Escape, and focus-restoration results remain unavailable |
| OS/browser forced colors or high contrast | NOT RUN / DEFERRED | Essential state and interaction cue validation remains unavailable |
| Actual reduced-motion preference | NOT RUN / DEFERRED | Active OS preference observation remains unavailable |

PR #39 remains Draft pending final CTO review. VoiceOver, forced-colors/high-contrast, and OS reduced-motion validation are explicit deferred limitations and have not been marked PASS.
