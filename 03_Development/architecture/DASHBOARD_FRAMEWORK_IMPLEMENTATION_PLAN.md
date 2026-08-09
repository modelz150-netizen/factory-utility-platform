# Dashboard Framework Implementation Plan

| Field | Value |
|---|---|
| Status | Review |
| Version | 0.1.0 |
| Date | 2026-08-09 |
| Backlog | `DASH-001` |
| Owner | Engineering with Product, Architecture, Accessibility, and QA sign-off |
| Scope authority | [Dashboard Framework Scope Proposal](../../01_Product/dashboard/DASHBOARD_FRAMEWORK_SCOPE_PROPOSAL.md) |
| Architecture authority | [Platform Architecture v1.0](PLATFORM_ARCHITECTURE_V1.md) |
| Experience dependency | [Design System Foundation](../../04_Design/design-system/FOUNDATION.md) |
| Decision authority | CTO review |

## 1. Purpose and Authorization Boundary

Define the implementation contract, sequencing, test seams, and approval gates for the reusable Dashboard Framework. This plan does not itself authorize framework code, a production Dashboard, utility-specific business UI, live operational data, SCADA or AI integration, database schema, authentication, chart-library selection, deployment, or release.

Framework implementation requires a separate dedicated Pull Request after this plan is approved. A business Dashboard or fixture-based vertical slice remains a later, separately authorized gate.

## 2. Responsibilities and Boundaries

### Dashboard Composition owns

- immutable dashboard, region, and widget descriptors;
- deterministic composition and placement contracts;
- explicit view-state orchestration from authorized read-model results;
- widget registration validation, identity, ownership, compatibility, and ordering;
- failure isolation and framework-level diagnostic context;
- responsive presentation hints that consume Active Design System primitives; and
- fixture seams for non-production validation.

### Experience Shell owns

- semantic header, primary navigation, main, complementary, and footer regions;
- stable reading and focus order across responsive layouts;
- destination labels, current-location presentation, skip navigation, and shell-level error boundaries;
- route-to-page delivery through an approved application contract; and
- consumption of Design System layout and accessibility primitives.

### Dashboard Composition does not own

- domain meaning, calculations, units, freshness rules, or source authority;
- direct persistence, WordPress globals, provider SDKs, APIs, AI, or SCADA;
- authentication or authorization decisions;
- utility-specific dashboards, widgets, charts, or workflows; or
- production data acquisition, caching policy, schema, or deployment.

Owning modules publish authorized application projections through ports. Server-side application boundaries decide access. UI visibility may reflect an access result but never substitutes for authorization.

## 3. Planned Physical Placement

| Path | Responsibility |
|---|---|
| `03_Development/platform/src/Experience/Shell` | shell and navigation presentation contracts |
| `03_Development/platform/src/Experience/Dashboard` | framework composition and renderer-facing contracts |
| `03_Development/platform/src/Modules/Dashboard/Application` | use-case orchestration and read ports without domain rules |
| `03_Development/platform/src/Modules/Dashboard/Domain` | only stable framework identities/value contracts if justified |
| `03_Development/platform/tests/Experience/Dashboard` | rendering, semantic, responsive, and interaction contracts |
| `03_Development/platform/tests/Architecture` | dependency and prohibited-access fitness rules |
| `03_Development/platform/tests/Fixtures/DashboardFramework` | fictional, visibly simulated, non-production fixtures |
| `05_QA` | executed architecture, accessibility, performance, and scope evidence |

No framework implementation may add a second composition root or deployable package. Experience depends on application contracts, never module Domain or Infrastructure implementation. Domain and Application remain independent of Design System CSS and WordPress.

## 4. Shell and Layout Contract

The shell contains one banner, one named primary navigation, one main landmark, an optional complementary region, and a contentinfo region. It reuses the Active Design System shell, container, stack, cluster, grid, focus, status, table, and dialog primitives.

- DOM order is the canonical reading and focus order; CSS shall not reorder meaning.
- Main content remains reachable through a skip link and receives programmatic focus after a deliberate client-side route transition when applicable.
- Widget placement is declarative and deterministic; it shall not encode business priority or user access.
- A failed widget occupies an explicit failure region and does not hide successful siblings.
- Wide layouts may expose navigation and complementary regions concurrently; narrow layouts preserve required content in one reading column.
- Framework regions do not assume fixed viewport height, hover, pointer precision, or JavaScript-only access.

## 5. Navigation and Routing

The initial navigation catalog contains stable destinations for Home, Executive, Utility Modules, Engineering Tools, Operations and Assets, Energy and Reports, and future AI. Utility sub-destinations are labels and route identities only; they do not authorize their screens or behavior.

Each destination contract defines a stable ID, localized label key, route name, owner, lifecycle state, optional parent, ordering hint, readiness state, and explicit access-result input. Future AI is visibly unavailable or future-state until separately authorized.

Routing requirements:

- route resolution enters through a delivery adapter and application port;
- unknown or unavailable destinations return explicit not-found or unavailable view states;
- route names are stable contracts and do not expose WordPress IDs or query implementation;
- redirects, history behavior, deep links, focus, page title, and current navigation state are testable;
- server-side access is decided before an authorized projection is returned; and
- no navigation fixture creates a production WordPress route.

## 6. Module and Widget Registration

A registry accepts immutable descriptors through the composition root. Registration is closed before request handling and rejects invalid or conflicting descriptors.

### Dashboard descriptor

- stable dashboard ID and contract version;
- owning module and accountable owner;
- title/description keys and lifecycle state;
- ordered regions and allowed widget slots;
- required application read capabilities; and
- compatibility range and deprecation metadata.

### Widget descriptor

- globally unique widget ID, version, owner, and lifecycle;
- renderer key and allowed region kinds;
- input projection contract and supported truthful states;
- responsive span hints, minimum useful width, and accessible alternative contract;
- latency and payload budget; and
- failure-isolation and observability category.

The registry shall reject duplicate IDs, unsupported versions, missing owners, unknown renderers, undeclared states, invalid placements, and direct adapter or provider dependencies. Registration discovers capability; it does not instantiate domain services, query data, or authorize users.

## 7. Read Ports and Projection Boundary

Widgets receive view-ready immutable projections from application read ports. They do not read module tables, repositories, WordPress metadata, remote sources, or another module's internals.

Every projection result contains:

- explicit outcome state;
- source/provenance disclosure appropriate to the data class;
- observation or publication timestamp when applicable;
- freshness classification supplied by the owning module;
- validation/readiness status;
- simulation disclosure;
- access-context result without credentials or sensitive policy detail; and
- privacy-safe correlation identifier for diagnostics.

The framework may map an explicit outcome to a presentation component. It shall not calculate freshness, infer trust, manufacture missing values, merge conflicting authorities, or convert an error into apparent success.

## 8. Truthful Data-State Handling

Required framework states are `loading`, `empty`, `partial`, `stale`, `unavailable`, `simulated`, and `error`. The Design System also supplies neutral, information, success, warning, critical, and unknown presentation semantics when explicitly provided.

| State | Framework presentation obligation |
|---|---|
| Loading | bounded progress text; no fabricated placeholder value; reduced-motion safe |
| Empty | confirms successful query with no content and offers a valid next step when one exists |
| Partial | identifies missing portions without hiding available qualified content |
| Stale | displays owner-supplied freshness label and timestamp; never recalculates freshness |
| Unavailable | distinguishes dependency or capability absence from an empty result |
| Simulated | persistent visible and programmatic disclosure on every affected value region |
| Error | safe message, correlation reference, recovery action when valid, and isolated failure boundary |

Status is conveyed through text and semantics, not color alone. Unknown, skipped, deferred, and unavailable remain distinct. Loading completion and live-region announcements shall avoid duplicate or disruptive speech.

## 9. Responsive Behavior

The framework supports continuous layouts from 320 through 2560 CSS pixels and records evidence at 320, 375, 768, 1024, 1440, 1920, and 2560. It also validates 200% browser zoom and applicable 400% reflow.

- placement uses content-driven grid rules and Design System breakpoints rather than device identity;
- widgets declare minimum useful width and permissible spans, never absolute screen coordinates;
- the framework uses one column when required to preserve readability and source/status context;
- tables scroll only within named containers and retain captions, headers, and accessible alternatives;
- charts, if authorized later, require a textual or tabular alternative and do not enter the foundation PR; and
- navigation collapse preserves destination access, current location, focus order, and 44 × 44 CSS-pixel targets.

## 10. Accessibility Requirements

WCAG 2.2 Level AA is the target. Framework acceptance requires:

- semantic landmarks, headings, navigation names, page titles, and current-location state;
- complete keyboard operation with visible `:focus-visible` treatment and no keyboard trap;
- predictable focus on navigation, errors, widget updates, dialogs, and recovery actions;
- accessible name, role, state, description, and non-color differentiation for every control/status;
- 200% text resize, applicable 400% reflow, forced-colors/high-contrast, and reduced-motion evidence;
- macOS VoiceOver navigation, widget, status, error, table, and route-transition smoke review;
- errors and partial/unavailable states announced proportionately without stealing focus; and
- 44 × 44 CSS-pixel minimum primary interaction targets.

The three deferred Design System validation limitations remain visible and must be executed for framework behavior where the environment supports them; prior deferral is not inherited as a PASS.

## 11. Failure Isolation, Observability, and Performance

Each widget renderer receives a bounded projection and produces an isolated result. One renderer exception or read failure becomes that widget's explicit error state while the shell and successful siblings remain available.

Framework diagnostics contain a privacy-safe correlation ID, dashboard/widget identity, contract version, outcome class, duration, and failure category. They exclude credentials, production values, personal data, and raw provider payloads.

Initial implementation budgets:

- no runtime UI framework or chart dependency;
- framework incremental compressed CSS at most 20 KB beyond the Active Design System;
- framework incremental compressed JavaScript at most 30 KB;
- fixture dashboard server-render path at most 200 ms p95 in controlled local tests, excluding fixture delay scenarios;
- widget registry and composition complexity linear in registered descriptors; and
- no synchronous dependency on an optional integration for shell/navigation availability.

Budgets are implementation gates, not production service claims.

## 12. Fixture Strategy

The non-production fixture set includes:

1. one generic dashboard descriptor;
2. header, primary navigation, main, complementary, and footer shell regions;
3. generic text, status, and table widget renderers;
4. explicit loading, empty, partial, stale, unavailable, simulated, and error projections;
5. a deliberate single-widget failure with successful sibling content;
6. allowed and denied visibility results without implementing authentication; and
7. narrow, medium, wide, zoom, high-contrast, reduced-motion, keyboard, and screen-reader cases.

All fixture content is fictional, visibly marked Demo or Simulated, and contains no engineering, plant, customer, credential, or production operational data. Fixtures call no WordPress route, persistence, API, AI, or SCADA service and are excluded from production registration.

## 13. Testing Strategy

### Automated

- descriptor schema, uniqueness, version compatibility, lifecycle, ownership, and registry closure;
- deterministic region placement and invalid-registration rejection;
- application-port-only projection access and dependency fitness;
- exhaustive truthful-state mapping without freshness or authority inference;
- failure containment and successful-sibling preservation;
- semantic HTML, landmarks, navigation state, labels, table contracts, live-region restraint, and focus targets;
- route resolution, not-found/unavailable behavior, title/current-location/focus contract;
- responsive screenshots and overflow checks at all evidence widths;
- CSS/JavaScript size, render timing, forbidden dependency, and production-data scans; and
- WordPress composition smoke test without registering fixture routes.

### Manual

- keyboard traversal, skip link, focus visibility, route focus, recovery, and dialog behavior;
- 200% zoom and applicable 400% reflow;
- VoiceOver reading order, navigation, widget headings, statuses, errors, tables, and route transitions;
- forced-colors/high-contrast and reduced-motion preferences;
- touch target and pointer-alternative review; and
- truthful content review for every state and failure isolation case.

Evidence distinguishes PASS, FAIL, NOT RUN, DEFERRED, UNAVAILABLE, and NOT APPLICABLE. Automation never substitutes for required manual evidence.

## 14. Implementation Sequence

1. approve this plan and exclusions;
2. define immutable descriptor, identity, version, lifecycle, and projection contracts;
3. implement registry validation and dependency-fitness rules;
4. implement semantic shell and navigation contracts using the Active Design System;
5. implement route resolution and explicit view-state orchestration;
6. add isolated generic renderers and failure boundaries;
7. build the non-production fictional fixture matrix;
8. execute automated architecture, behavior, accessibility, responsive, and budget checks;
9. execute independent manual Product, Accessibility, Engineering, and QA review;
10. record evidence and request final CTO approval without implementing a business Dashboard.

## 15. Risks and Controls

| Risk | Control |
|---|---|
| Framework becomes a second application layer | presentation and read orchestration only; application ports own use cases |
| Registry becomes a service locator | immutable descriptors only; composition root assembles dependencies |
| UI hiding becomes authorization | server-side access result required before projection; visibility is presentation only |
| Framework infers freshness or trust | owner-supplied explicit metadata; exhaustive no-inference tests |
| Responsive placement changes meaning | stable DOM order and content-preserving placement rules |
| Fixture becomes a production dashboard | no production route, data, registration, domain labels, or integrations |
| One widget collapses the page | isolated result and renderer failure boundaries |
| Accessibility deferrals silently become PASS | evidence taxonomy and named manual gates |
| WordPress coupling leaks inward | adapter-only routing and existing dependency fitness rules |

## 16. Definition of Done

Dashboard Framework implementation is complete only when:

- shell, navigation, route, descriptor, registry, projection, state, placement, and isolation contracts exist in the approved package boundaries;
- Domain and Application remain independent of Experience, Design System implementation, WordPress, and providers;
- every required truthful state has visible and machine-testable semantics without inferred authority or freshness;
- the fictional fixture proves composition, responsive behavior, access-result visibility, and one-widget failure containment without Product behavior;
- automated tests and dependency fitness pass with no Critical, Major, WCAG Critical, or WCAG Serious issue;
- keyboard, focus, VoiceOver, zoom, reflow, forced-colors/high-contrast, and reduced-motion evidence is truthfully recorded;
- size and controlled render-time budgets pass or have an explicit approved exception;
- no Dashboard business UI, utility screen, production data, integration, schema, authentication, chart library, or deployment is introduced;
- Backlog, Changelog, AI Status, documentation, and QA evidence are synchronized; and
- Product, Architecture, Accessibility, Engineering, QA, and CTO approve the dedicated implementation Pull Request before merge.

Approval of the framework implementation does not authorize a production Dashboard or the fixture-based vertical slice. Those remain separate gates.
