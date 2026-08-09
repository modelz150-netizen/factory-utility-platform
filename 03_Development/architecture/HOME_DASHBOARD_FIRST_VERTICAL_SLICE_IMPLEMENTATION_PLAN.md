# Home Dashboard First Vertical Slice Implementation Plan

| Field | Value |
|---|---|
| Status | Review |
| Version | 0.1.0 |
| Date | 2026-08-09 |
| Backlog | `DASH-003` |
| Approval authority | CTO and Utility Manager |
| Scope authority | [Home Dashboard First Vertical Slice Scope Proposal](../../01_Product/dashboard/HOME_DASHBOARD_FIRST_VERTICAL_SLICE_SCOPE_PROPOSAL.md) Version 0.2.0 |

## 1. Purpose and authorization boundary

This plan defines the implementation contract for the first Home Dashboard vertical slice. It does not authorize implementation. A separate implementation branch and Pull Request may begin only after this plan receives explicit CTO and Utility Manager approval.

The slice will be production-oriented in structure but will use only conspicuously labelled `SIMULATED` fixture data. It will introduce no live integration, production data, control behavior, alarm evaluation, KPI formula, database, authentication, AI, CMMS, notification service, detailed Utility screen, or deployment behavior.

## 2. Binding decision hierarchy

The dashboard shall optimize the following decision sequence:

`ABNORMALITY → SEVERITY → AFFECTED UTILITY → DURATION → REDUNDANCY / AVAILABILITY IMPACT → MANAGEMENT ACTION`

Operational reliability shall visually and structurally outrank energy and water cost context. Stable English identifiers control behavior; localized labels never do.

## 3. Planned package boundaries

The implementation shall remain inside the approved modular monolith and Dashboard Framework boundaries:

- `Domain`: health aggregation policy, state invariants, and domain value contracts only.
- `Application`: Home Dashboard read ports, projection contracts, orchestration, validation, and supplied ordering.
- `Adapters`: simulated fixture implementations of Application read ports only.
- `Experience`: page composition, widgets, localization keys, formatting, responsive presentation, and accessible interaction.
- `Tests`: unit, contract, architecture-fitness, fixture, rendering, accessibility, responsive, and performance checks.

Planned ownership is `src/Modules/HomeDashboard/{Domain,Application}`, `src/Adapters/HomeDashboard/Fixture`, and `src/Experience/HomeDashboard`. Exact files are an implementation detail, but dependency direction is binding: Experience and Adapters depend inward on Application contracts; Domain and Application shall not depend on Experience, WordPress, or fixture implementations. WordPress may compose and enqueue approved assets but shall not own dashboard behavior.

## 4. Page composition and visual priority

Deterministic document and visual order:

1. Page heading, plant-local time context, global simulation disclosure, and page-level freshness/provenance summary.
2. Decision row: Overall Utility Health, Critical Alarm Summary, Management Attention.
3. Utility System Overview: eight cards in approved management order.
4. P0 KPI Summary.
5. Reliability Risk.
6. Work / Maintenance Summary.
7. P1 energy and water context, only when supplied as truthful projections or explicit placeholders.

The first viewport shall make abnormality, severity, affected Utility, duration, redundancy impact, and management-action need discoverable within seconds. Critical operational content shall never be displaced below P1 cost analytics.

## 5. Widget responsibility map

| Widget | Supplied input | Experience responsibility | Prohibited responsibility |
|---|---|---|---|
| Overall Utility Health | Aggregate health projection | Present state, affected count/list, freshness, policy/version provenance | Calculate, average, score, or downgrade health |
| Critical Alarm Summary | Alarm summary projection | Present counts, latest event, age, and Utility | Evaluate severity or acknowledgement |
| Management Attention | Already ordered attention projection | Preserve supplied order and present action context | Re-prioritize or infer action |
| Utility Overview | Eight ordered Utility projections | Render comparable summaries and future routes | Compute state or load Utility detail |
| P0 KPI Summary | Four supplied KPI projections | Format value/unit/state/provenance | Calculate KPI or invent target |
| P1 Context | Supplied projection or placeholder | Show subordinate simulated/unavailable context | Compete visually with reliability content |
| Reliability Risk | Supplied risk projection | Present unavailable equipment, abnormality, redundancy, and data risk | Diagnose or score risk |
| Work / Maintenance | Supplied simulated or unavailable projection | Disclose authority and state | Implement CMMS/workflow or imply truth |

Each widget shall accept an immutable projection, expose a stable accessible heading, and fail independently without preventing other widgets from rendering.

## 6. Application read-port contracts

The Application layer shall own a single page-oriented `HomeDashboardReadPort` or a deterministic orchestrator over narrowly scoped ports. The selected shape must preserve these capabilities:

- fetch the complete page projection for one plant context and requested instant;
- return typed projections, not HTML or translated labels;
- preserve source timestamps, timezone provenance, simulation marker, quality, and freshness;
- return partial results when one source fails;
- distinguish `loading`, `stale`, `partial`, `unavailable`, and successful states;
- accept no WordPress or browser types;
- expose stable English Utility, state, KPI, and action-category keys.

The detailed field catalogue is normative for implementation planning: [Home Dashboard Projection Contract Catalogue](HOME_DASHBOARD_PROJECTION_CONTRACT_CATALOGUE.md).

## 7. Fixture adapter contracts

Fixture adapters shall implement the same Application read ports intended for future SCADA, BMS/FMS, manual-input, maintenance, energy, or external-API adapters. They shall:

- be explicitly named and registered as fixtures;
- emit `simulation: true` and a visible `SIMULATED` source classification;
- use fictional identifiers and values;
- be deterministic for a named scenario and clock;
- support complete, partial, stale, unavailable, malformed, and per-port failure cases;
- perform no network, database, filesystem polling, or production registration;
- never masquerade as an authoritative maintenance source.

## 8. Projection contracts and invariants

### 8.1 Overall Utility Health

Application/Domain policy supplies the projection. Experience presents it without calculation. The implementation plan requires a versioned, exhaustively tested aggregation policy before code is accepted. At minimum:

The initial `overall-health/1.0` policy evaluates the configured eight expected Utility inputs in this exact order:

1. If any trustworthy supplied operational state is `critical`, aggregate state is `critical`.
2. Otherwise, if any trustworthy supplied operational state is `warning`, aggregate state is `warning`.
3. Otherwise, if all expected Utility inputs are unavailable, aggregate state is `unavailable`.
4. Otherwise, if any expected input is missing, unavailable, or operationally unknown, aggregate state is `unknown` and completeness is `partial`.
5. Otherwise, if any input is stale, aggregate state is `stale`.
6. Only when every expected input is present, trustworthy, fresh, and `normal` is aggregate state `normal`.

The state decision is a precedence policy, never an average, numeric score, percentage, or majority vote. A Critical or Warning operational state therefore remains dominant even when another input is stale or unavailable; the projection simultaneously carries the degraded completeness/freshness limitation. A stale last-known Critical/Warning input retains its supplied operational severity and separately carries stale freshness. Affected Utility keys include every non-Normal, missing, stale, unknown, or unavailable contributor and are supplied with the count. Policy identifier/version and as-of instant are traceable. Any future policy change requires versioning, decision-table regression evidence, and approval.

### 8.2 Alarm summary

The supplied projection includes critical count, warning count, unacknowledged count, latest major event, duration-based age, and affected Utility/system. Home Dashboard neither evaluates alarms nor assigns severity or acknowledgement.

### 8.3 Management Attention

Application supplies an already-prioritized, stable sequence. Each item supports severity, affected Utility, concise condition key/parameters, duration, reliability/redundancy impact, management-attention category, freshness, and future route. Experience shall not sort by translated text, color, age, or local heuristics.

### 8.4 Utility summaries

One common contract serves the fixed initial order: Electrical, CDA, DI / RO, PCW, Chiller / Cooling Tower, AHU / HVAC, WWT, Energy. Ordering is supplied by configuration/Application so future changes require no widget rewrite. Cards expose management summary only, not raw sensor arrays.

### 8.5 P0 and P1 KPIs

P0 contracts are Utility Availability, Active Abnormalities, Major Equipment Availability, and Data Freshness. Values, units, periods, state, source, and formula/policy provenance are supplied; Experience calculates none and invents no target.

Energy Consumption and Water Consumption are P1. Until authoritative definitions exist, each is either a clearly simulated supplied projection or a truthful unavailable/not-configured placeholder. P1 shall remain visually subordinate.

### 8.6 Reliability and maintenance

Reliability Risk may present supplied equipment-unavailable, abnormal-condition, degraded-redundancy, overdue-maintenance, and stale/missing-data items. Work/Maintenance may present PM due, overdue PM, open corrective actions, and major ongoing work only as explicitly simulated fixtures or `unavailable` when no authoritative contract exists.

## 9. Time, freshness, and provenance

- Plant timezone is `Asia/Ho_Chi_Minh` (`UTC+07:00`).
- Source instants and their timezone/offset provenance remain preserved internally.
- Absolute timestamps display in plant local time by default and are localized without changing the instant.
- Alarm/event age is a supplied or Application-derived duration from an injectable clock; Experience formats but does not reinterpret it.
- Every projection exposes observed/as-of time, source class, simulation status, quality, and freshness state where applicable.
- Staleness thresholds belong to the authoritative Application/domain policy or source contract, never CSS or translated text.
- Page and widget disclosures shall prevent simulated, partial, stale, or unavailable information from appearing live/current.

## 10. Localization strategy

English remains canonical for keys and contracts. Central resources shall cover `ko-KR`, `vi-VN`, and `en-US`, using the Dashboard Framework fallback to `en-US`.

Keys shall be namespaced under `home.*`, including page regions, widget headings, Utility labels, stable state labels, attention categories, simulation/provenance disclosures, empty/error text, and accessible names. Parameterized strings shall carry typed values separately; pluralization shall be used for affected systems, alarms, and items. Dates, numbers, durations, and units use the approved locale-aware formatter. No module or component shall hard-code user-facing prose or branch on a translation.

Fixtures and visual evidence shall exercise Korean, Vietnamese, and English text expansion, diacritics, Unicode, fallback fonts, missing-key behavior, and deterministic fallback.

## 11. Responsive behavior

- Desktop (`1024` and above): decision row receives primary width; eight Utility cards use a dense, consistent multi-column grid; KPI/risk/work sections remain aligned.
- Tablet (`768`): regions reflow without changing semantic order or hiding severity/provenance.
- Mobile (`320` and `375`): single-column decision sequence, compact Shell navigation, concise card summaries, and early exposure of primary abnormal content.
- Wide (`1440`, `1920`, `2560`): bounded readable content width and denser columns without excessive empty space.
- No fixed English-string widths; values and labels may wrap without overlap, clipping, or page-level horizontal scrolling at applicable reflow widths.

## 12. Accessibility requirements

Implementation shall satisfy WCAG 2.2 AA and the approved Design System contract: semantic landmarks and heading order, keyboard-only operation, visible focus, 44 by 44 CSS-pixel interactive targets, programmatic name/role/state, color-independent severity, meaningful reading order, accessible loading/error announcements without excessive interruption, reduced-motion support, forced-colors resilience, 200% text zoom, and applicable 400% reflow.

Cards shall not become interactive containers when only a drill-down link is actionable. Tables, if used at wider widths, require semantic headers and a non-lossy narrow presentation. Time, state, simulation, and provenance must be available to assistive technology.

## 13. Failure isolation and truthful states

The page orchestrator shall map individual port/widget failures into contained projections. A failed Alarm widget shall not erase Utility Health or other summaries. Each region shall support relevant states:

- `loading`: pending, with non-misleading skeleton/progress semantics;
- `stale`: last-known data retained with explicit age/provenance;
- `partial`: useful subset present with missing scope disclosed;
- `unavailable`: no trustworthy value, with no fabricated zero;
- `unknown`: source cannot determine operational state;
- `empty`: authoritative query succeeded with no items;
- `simulated`: fixture origin remains visible in conjunction with the operational state.

No exception detail, stack trace, or sensitive source identifier shall enter user-facing output.

## 14. Fixture scenario catalogue

The implementation shall provide deterministic named scenarios described in [Home Dashboard Fixture Scenario Catalogue](HOME_DASHBOARD_FIXTURE_SCENARIO_CATALOGUE.md). The default review scenario shall include at least one Critical condition, one degraded redundancy condition, duration and attention context, a partial/stale example, all eight Utilities, all P0 KPIs, subordinate P1 context, and simulated or unavailable maintenance. A completely normal scenario is required but shall not be the only evidence.

## 15. Test strategy and matrix

| Layer | Required verification |
|---|---|
| Domain | Exhaustive health-policy state combinations; Critical dominance; missing/untrusted input behavior; no averaging/scoring concealment |
| Application | Contract construction, stable supplied order, duration clock, timezone conversion boundary, partial orchestration, provenance retention |
| Adapter | Fixture schema compliance, deterministic scenarios, simulated marker, fictional data, failure cases, no external access |
| Experience | No calculations/sorting, widget state rendering, failure isolation, localization/fallback/plurals, formatting, escaping |
| Architecture | Dependency direction, namespace ownership, no direct adapter access, no WordPress/domain leakage, no production connector |
| Accessibility | semantics, keyboard/focus, 44px targets, contrast, non-color state, announcements, zoom/reflow, forced colors, reduced motion, screen reader |
| Responsive | `320 / 375 / 768 / 1024 / 1440 / 1920 / 2560`, all locales representative, no global overflow |
| Security | escaped localized parameters and fixture content, dependency audit, no secrets/endpoints/production identifiers |
| Regression | full PHPStan, PHPUnit, syntax, dependency-fitness, security, smoke, asset, and Markdown-link suites |

## 16. Performance budget

These budgets are implementation acceptance budgets, not production SLAs:

- no new UI framework, charting library, external font, or runtime network dependency;
- Home Dashboard incremental CSS at most 16 KiB gzip;
- Home Dashboard incremental JavaScript at most 24 KiB gzip;
- default fixture payload at most 100 KiB uncompressed;
- no more than one Application page-read orchestration per initial render;
- deterministic composition of the initial widgets in at most 50 ms at the unit benchmark boundary on the project QA environment, excluding I/O and deliberate fixture delay;
- zero cumulative layout shift caused by late fixture content in the review harness;
- all budgets measured by repeatable scripts and recorded with environment/limitations.

Any proposed exception requires evidence and CTO approval before merge.

## 17. Architecture fitness rules

Automated checks shall reject:

- Domain/Application imports from Experience, WordPress, or Adapters;
- Experience access to fixture classes or source-specific clients;
- adapter-owned projection interfaces;
- health, alarm, KPI, attention priority, freshness, or reliability calculation in Experience/JavaScript/CSS;
- behavior controlled by localized strings;
- hard-coded production endpoint, credential, plant identifier, or operational record;
- non-simulated fixture registration or missing simulation disclosure;
- reordering of Management Attention or Utilities by presentation code;
- modification of the approved Design System or Dashboard Framework to embed Home Dashboard behavior.

## 18. Visual acceptance matrix

| Evidence | Viewport / mode | Required observations |
|---|---|---|
| Korean desktop | 1440 CSS px, `ko-KR` | hierarchy, Unicode, text expansion, critical prominence, all sections |
| Vietnamese desktop | 1440 CSS px, `vi-VN` | diacritics, wrapping, localized formats, no clipping |
| English desktop | 1440 CSS px, `en-US` | canonical fallback, density, ordering, provenance |
| Korean mobile | 375 CSS px, `ko-KR` | primary content early, single-column order, compact navigation |
| English mobile | 320 or 375 CSS px, `en-US` | reflow, action clarity, no page overflow |
| Wide desktop | 1920 and 2560 CSS px | bounded readable density, no sparse expansion |
| Zoom | actual browser 200% | no lost content/control, visible focus |
| Reflow | applicable browser 400% | usable order, no prohibited page-level horizontal scrolling |
| Assistive modes | VoiceOver, forced colors/high contrast, reduced motion | name/role/state/order, essential cues, minimized motion; unrun checks remain Deferred, never PASS |

Screenshots shall show a visible locale, `SIMULATED` disclosure, scenario name, viewport, and capture date. Manual results and limitations belong in QA evidence.

## 19. Implementation sequence after approval

1. Freeze projection interfaces, invariants, and health-policy test vectors.
2. Implement Domain/Application policy and ports with unit tests.
3. Implement deterministic fixture adapters and schema validation.
4. Compose widgets through the existing Dashboard Framework without modifying it.
5. Add centralized locale resources and formatting keys.
6. Add responsive/accessibility presentation using the existing Design System.
7. Add architecture, performance, security, and regression checks.
8. Capture multilingual desktop/mobile and accessibility evidence.
9. Submit a dedicated Draft implementation PR; no business expansion follows automatically.

## 20. Definition of Done

The later implementation is Done only when:

- all contracts and invariants in this plan and the catalogues are implemented and traceable;
- the fail-safe health policy is specified, versioned, exhaustively tested, and cannot conceal Critical;
- Experience performs no domain calculation, priority decision, or source access;
- all eight Utilities, top decision widgets, P0 KPIs, P1 strategy, reliability, and maintenance truth states are represented;
- fixtures are fictional, deterministic, explicitly simulated, and include failure/stale/partial/unavailable cases;
- `ko-KR`, `vi-VN`, and `en-US` render through centralized localization with English fallback;
- timezone, duration, freshness, quality, and provenance remain truthful;
- responsive, keyboard, focus, zoom/reflow, screen-reader, forced-color, and reduced-motion evidence is recorded truthfully;
- performance budgets and complete automated validation pass with zero Critical or Major defect;
- no protected Charter/Architecture, Design System Foundation, or Dashboard Framework change occurs;
- no excluded integration, production data, formula, control, schema, authentication, AI, CMMS, notification, detailed screen, or deployment is introduced;
- CTO and Utility Manager approve the dedicated implementation PR and its QA evidence.

## 21. Explicit exclusions

Real SCADA/BMS/FMS connections, real alarm evaluation, real KPI formulas, operational data, database schema, authentication, AI/Gemma, CMMS, notifications, control commands, Utility detailed screens, and production deployment remain outside this plan and unauthorized.
