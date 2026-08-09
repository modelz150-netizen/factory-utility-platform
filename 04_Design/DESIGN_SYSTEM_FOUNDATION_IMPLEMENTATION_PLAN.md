# Design System Foundation Implementation Plan

| Field | Value |
|---|---|
| Status | Review |
| Version | 0.1.0 |
| Date | 2026-08-09 |
| Backlog | `DES-001` |
| Owner | Product design with Accessibility, Engineering, and QA sign-off |
| Scope authority | [Design System Foundation Scope](DESIGN_SYSTEM_FOUNDATION_SCOPE_PROPOSAL.md) |
| Architecture dependency | [Physical Package Foundation](../03_Development/architecture/PHYSICAL_PACKAGE_FOUNDATION.md) |
| Decision authority | CTO review |

## 1. Purpose and Authorization Boundary

Define the implementation contract, sequence, evidence, and approval gates for the minimum reusable Design System required before Dashboard Framework work. This plan authorizes no CSS, JavaScript, component, Dashboard, WordPress theme, or Product UI implementation by itself.

The future implementation shall be delivered in one dedicated Pull Request after this plan is approved. Dashboard Framework and Dashboard business UI remain outside that Pull Request.

## 2. Foundation Deliverables

The implementation Pull Request shall contain only:

1. versioned design-token sources and generated native CSS custom properties;
2. typography, spacing, sizing, color, elevation, motion, focus, and responsive foundations;
3. semantic status contracts and truthful state presentation rules;
4. accessible, behavior-light UI primitives;
5. Experience Shell layout principles expressed through non-Product fixtures;
6. theme and WordPress presentation boundaries;
7. first-party icon and asset rules;
8. a fixture/demo harness that is excluded from production loading;
9. automated and manual validation configuration; and
10. Architecture, Accessibility, and QA evidence.

## 3. Planned Physical Placement

| Path | Responsibility |
|---|---|
| `03_Development/platform/assets/design-system/tokens` | governed token source files grouped by primitive, semantic, and component alias layers |
| `03_Development/platform/assets/design-system/css` | reset, foundation, layout, primitive, utility, and theme CSS entry points |
| `03_Development/platform/assets/design-system/icons` | reviewed first-party SVG sources and icon manifest |
| `03_Development/platform/src/Experience/DesignSystem` | PHP-side presentation contracts only when server rendering requires them |
| `03_Development/platform/tests/Experience` | structure, contract, and rendering tests |
| `03_Development/platform/tests/Fixtures/DesignSystem` | non-production component and shell fixtures with no engineering or operational data |
| `04_Design/design-system` | usage documentation, accessibility notes, token catalog, and component lifecycle records |
| `05_QA` | executed visual, responsive, accessibility, performance, and scope evidence |

Domain, Application, Infrastructure, and provider adapters shall not depend on Design System implementation details. The WordPress boundary may enqueue approved assets but shall not define tokens, components, or Product behavior.

## 4. Design Token Model

Tokens use three non-duplicative layers:

| Layer | Purpose | Example naming form |
|---|---|---|
| Primitive | raw reusable scale without UI meaning | `--fup-color-blue-600`, `--fup-space-4` |
| Semantic | intent that survives theme changes | `--fup-color-text-primary`, `--fup-color-status-warning` |
| Component alias | narrow primitive requirement when shared semantics are insufficient | `--fup-button-min-height` |

Component aliases may reference semantic or primitive tokens but shall not duplicate raw values. A token requires owner, description, type, value, theme behavior, accessibility constraint, and deprecation state.

### Required Categories

- color: surfaces, text, borders, actions, focus, overlays, and semantic status;
- typography: font families, weights, sizes, line heights, letter spacing, and measure;
- spacing: a 4 CSS-pixel base scale with named steps from 0 through 48 pixels;
- sizing: control heights, icon sizes, content widths, shell regions, and minimum touch target;
- elevation: bounded surface levels with border fallback where shadow perception is insufficient;
- motion: duration and easing tokens with reduced-motion alternatives; and
- layering: named z-index roles for base, sticky, navigation, overlay, dialog, and notification.

Final brand colors, marketing typography, and ornamental styling remain outside the foundation. Initial functional values must pass contrast and reflow evidence before approval.

## 5. Typography

- use a system-first sans-serif stack to avoid a critical-font transfer dependency in the foundation;
- provide a separate tabular-numeric stack for engineering values without changing the semantic meaning of numbers;
- define body, label, caption, heading, code, and data styles through tokens rather than element-specific one-offs;
- maintain readable line height and a default content measure near 65–75 characters;
- preserve browser text resizing and avoid fixed-height text containers; and
- distinguish hierarchy through size, weight, spacing, and semantics rather than color alone.

## 6. Spacing and Sizing

The base spacing scale is `0, 4, 8, 12, 16, 20, 24, 32, 40, 48` CSS pixels. Exceptions require a documented component constraint.

- primary interactive targets have a minimum 44 by 44 CSS-pixel target area;
- dense engineering tables may use compact visible cells only when row actions retain the minimum target area;
- containers use fluid inline padding and bounded readable widths;
- no primitive assumes a fixed viewport height; and
- sizing tokens shall distinguish content size, control size, and layout region size.

## 7. Semantic Status System

Required states are `neutral`, `information`, `success`, `warning`, `critical`, `unknown`, `loading`, `empty`, `partial`, `stale`, `unavailable`, and `simulated`.

Every status shall define:

- visible text and optional reviewed icon;
- non-color differentiation;
- semantic role and accessible-name behavior;
- source, timestamp, freshness, or simulation disclosure when applicable;
- compact and expanded presentation; and
- behavior under high contrast, forced colors, reduced motion, and monochrome output.

Status components present state only. They shall not calculate freshness, infer authority, or own domain rules.

## 8. Responsive Breakpoints and Layout

The implementation shall be mobile-first and valid continuously from 320 through 2560 CSS pixels. Initial content-driven breakpoints are:

| Name | Minimum width | Intended evidence |
|---|---:|---|
| `base` | 0 | 320–479 pixel phones and narrow reflow |
| `compact` | 480 px | large phones and compact controls |
| `medium` | 768 px | portrait tablets and two-region layouts |
| `wide` | 1024 px | landscape tablets and compact desktop shell |
| `large` | 1440 px | expanded desktop composition |

Breakpoints are layout thresholds, not device identities. Components prefer container-aware adaptation when it reduces page-level coupling. Required evidence covers 320, 375, 768, 1024, 1440, 1920, and 2560 CSS pixels plus 200% text resize and applicable 400% reflow.

Tables, dialogs, navigation, charts, filters, errors, and status regions require explicit narrow-width behavior. Horizontal scrolling is permitted only inside a named data container with preserved headers and an accessible alternative.

## 9. Accessibility, Focus, and Keyboard Rules

WCAG 2.2 Level AA is the target. Automated checks supplement but do not replace manual evidence.

- semantic HTML is the default; ARIA is added only when native semantics are insufficient;
- all interactive elements have accessible names, roles, states, and deterministic keyboard operation;
- focus uses a shared `:focus-visible` ring with at least a two-pixel visible indicator and separation from adjacent colors;
- focus order follows reading order and is not rearranged through positive `tabindex`;
- dialogs move focus into the dialog, contain focus while modal, close on supported Escape behavior, and restore focus to the invoker;
- menus, tabs, disclosure controls, and composite widgets document their key map before implementation;
- errors are associated with fields, summarized when necessary, and never communicated by color alone;
- skip navigation reaches the primary content landmark;
- motion honors `prefers-reduced-motion` and never blocks understanding; and
- screen-reader smoke evidence covers navigation, form errors, status changes, table context, and dialog lifecycle.

## 10. Shared UI Primitives

The minimum candidate catalog is:

- landmark and content wrappers;
- heading, text, link, and skip-link;
- button and icon button;
- label, hint, error, text input, textarea, select, checkbox, and radio;
- field group and form summary;
- status message, badge, alert, progress, and loading indicator;
- panel/card as a presentation container without domain meaning;
- responsive table wrapper with caption and header requirements;
- disclosure and dialog; and
- visually hidden and focus-management utilities.

Each primitive requires purpose, allowed variants, anatomy, semantic element, keyboard behavior, focus behavior, states, responsive behavior, content guidance, forbidden uses, ownership, test coverage, and deprecation policy.

No chart library, Dashboard widget, authentication control, data-fetching behavior, or domain-specific component belongs in this catalog.

## 11. Component States and Lifecycle

Interactive primitives cover `default`, `hover`, `focus-visible`, `active`, `disabled`, `read-only`, `invalid`, `loading`, and `success` where meaningful. Content containers cover `loading`, `empty`, `partial`, `stale`, `unavailable`, `simulated`, and `error` without inventing domain status.

Components use `Draft`, `Review`, `Active`, `Deprecated`, and `Removed` lifecycle states. Breaking changes require migration notes and a removal gate. A component becomes Active only after Design, Accessibility, Engineering, and QA evidence is complete.

## 12. Desktop and Mobile Shell Principles

- one semantic header, navigation region, main region, and optional complementary region;
- primary content and status remain available without hover, wide screens, or JavaScript-only navigation;
- narrow layouts use one reading column and progressive disclosure without hiding required engineering context;
- wider layouts may expose a navigation rail and complementary region but preserve DOM and focus order;
- shell regions consume Design System tokens and primitives only; and
- fixture shell content is generic and shall not become a Dashboard implementation or navigation authorization rule.

## 13. Theming Boundary

The foundation defines semantic theme contracts, not final branding. The default theme is light. Additional themes may override semantic tokens through a single root theme attribute only after contrast and state evidence passes.

- themes cannot change semantic meaning, DOM order, access decisions, or component behavior;
- user-agent forced colors and user preferences take precedence over decoration;
- WordPress themes may host or enqueue assets but shall not redefine Platform tokens privately; and
- site-specific branding requires a separately reviewed semantic-token mapping, never direct component forks.

## 14. CSS Architecture

Use native CSS custom properties and cascade layers in this order:

1. `reset` — minimal normalization;
2. `tokens` — primitive and semantic variables;
3. `base` — elements, typography, and focus defaults;
4. `layout` — containers, stack, cluster, grid, and shell objects;
5. `components` — primitive component styles;
6. `utilities` — small accessibility and layout utilities; and
7. `overrides` — explicit host integration only.

Selectors remain low-specificity, component-scoped, and independent of WordPress page IDs or domain data. `!important` is prohibited except for documented accessibility utilities. The initial compressed CSS budget is at most 100 KB, with a lower implementation target recorded before coding. No CSS preprocessor or runtime styling library is selected by this plan.

## 15. Asset and Icon Strategy

- use reviewed first-party SVG assets with a consistent 24-unit coordinate system;
- icons inherit color through `currentColor` unless semantic multi-color meaning is approved;
- decorative icons are hidden from assistive technology;
- informative icons require adjacent text or an accessible name supplied by the owning control;
- icon-only actions require an accessible name and visible focus treatment;
- no remote icon font, third-party runtime icon service, embedded tracking metadata, or unreviewed vendor asset is allowed; and
- asset filenames, licenses, source, optimization, and replacement path are recorded in a manifest.

## 16. Fixture and Demo Strategy

The implementation uses a non-production fixture harness to validate the Shell, navigation primitives, form controls, status states, one generic data panel, a responsive table, and a dialog.

- fixtures contain fictional, non-sensitive, non-operational content;
- every data-like example is visibly marked `Demo` or `Simulated`;
- fixtures do not call WordPress, a database, an API, AI, SCADA, or a Product module;
- the harness is excluded from production asset registration and packaging; and
- visual snapshots support review but do not replace semantic, keyboard, or screen-reader checks.

## 17. Testing and Accessibility Validation

### Automated

- token schema, references, uniqueness, and theme completeness;
- CSS syntax, forbidden selectors, specificity, and bundle-size budget;
- HTML semantics and required component attributes;
- keyboard-oriented interaction contracts for interactive primitives;
- automated WCAG scan with zero Critical or Serious violations on required fixtures;
- responsive screenshots and overflow checks at the evidence widths;
- reduced-motion, forced-color, zoom, and reflow checks where automation is reliable; and
- dependency fitness confirming that Domain and Application packages do not import Experience implementation.

### Manual

- complete keyboard traversal and visible-focus review;
- screen-reader smoke tests on macOS/Safari and one additional supported browser/platform pairing;
- 200% text resize and applicable 400% reflow;
- contrast review for text, non-text controls, focus, and all semantic statuses;
- touch-target and pointer-alternative review;
- high-contrast/forced-color and reduced-motion review; and
- content review for empty, stale, unavailable, simulated, error, and recovery states.

Evidence records browser, operating system, viewport, zoom, assistive technology, tool version, result, limitation, and reviewer. Passed, failed, skipped, unavailable, and not applicable remain distinct.

## 18. Implementation Sequence

1. approve this implementation plan and its exact exclusions;
2. create the token schema and validation contract;
3. implement reset, base typography, spacing, sizing, focus, and semantic status tokens;
4. implement layout objects and the non-Product Shell fixture;
5. implement the minimum primitive catalog in dependency order;
6. add fixture states, responsive evidence, and accessible alternatives;
7. execute automated validation and remediate failures;
8. execute independent Accessibility and QA manual review;
9. record Architecture, Design, Accessibility, and QA evidence; and
10. request CTO approval without beginning Dashboard Framework work.

## 19. Risks and Controls

| Risk | Control |
|---|---|
| tokens encode one screen | validate against Shell, form, status, table, dialog, and generic data-panel fixtures |
| accessibility becomes automation-only | require named Accessibility sign-off and manual keyboard/screen-reader/reflow evidence |
| CSS leaks into WordPress or domain concerns | enforce cascade boundaries, low-specificity selectors, and package dependency tests |
| fixture becomes Product UI | prohibit routes, domain data, authorization, persistence, and production registration |
| semantic status is inferred in presentation | accept explicit state metadata only and keep freshness rules in owning modules |
| responsive behavior is deferred | require the full evidence-width matrix before activation |
| asset dependency creates lock-in | use first-party SVG sources and a governed manifest |
| component catalog expands prematurely | require two-use evidence or approved Shell necessity for shared admission |

## 20. Definition of Done

Design System Foundation implementation is complete only when:

- all authorized token categories, CSS layers, primitives, states, responsive rules, theme boundaries, and asset rules exist in their approved paths;
- token and component catalogs identify owner, lifecycle, accessibility contract, variants, and forbidden uses;
- Shell, navigation, form, status, data panel, table, and dialog fixtures validate reuse without Product behavior;
- Composer and Physical Package Foundation checks remain green;
- CSS, token, unit, interaction, dependency, responsive, and automated accessibility checks pass;
- manual keyboard, focus, screen-reader, contrast, resize, reflow, forced-color, and reduced-motion evidence is recorded;
- required Design, Accessibility, Engineering, and QA reviewers sign off;
- no unresolved Critical, Major, WCAG Critical, WCAG Serious, or scope-expansion issue remains;
- CSS and asset budgets pass or have an explicit approved exception;
- Backlog, Changelog, AI Status, documentation, and QA evidence are synchronized;
- the Master Project Charter, Platform Architecture, and frozen Governance Architecture remain unchanged; and
- no Dashboard Framework, Dashboard business UI, live integration, schema, authentication, or production deployment is introduced.

Approval of this plan authorizes only a dedicated Design System Foundation implementation Pull Request. Dashboard Framework work requires the completed and approved Design System foundation plus its own gate.
