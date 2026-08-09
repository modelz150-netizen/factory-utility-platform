# Home Dashboard — First Vertical Slice Scope Proposal

| Field | Value |
|---|---|
| Status | Review |
| Version | 0.1.0 |
| Date | 2026-08-09 |
| Backlog | `DASH-002` |
| Phase | Phase 2-B — Home Dashboard First Vertical Slice Scope |
| Owner | Product with Utility Manager, Architecture, Design, Accessibility, Engineering, and QA review |
| Scope authority | [First Vertical Slice Proposal](../../03_Development/architecture/FIRST_VERTICAL_SLICE_PROPOSAL.md) |
| Framework dependency | Dashboard Framework Version 1.0.0 |
| Experience dependency | Design System Foundation Version 1.0.0 |
| Decision authority | CTO and Utility Manager review |

## 1. Purpose and Authorization Boundary

Define the first production-oriented management experience for Factory Utility Platform without authorizing production implementation. The Home Dashboard shall help a semiconductor-factory Utility manager understand overall Utility condition, major risks, alarms, reliability, work exposure, and high-level operational indicators at a glance.

This proposal refines the approved fixture-based vertical-slice direction for the Home Dashboard. It authorizes planning and review only. Any implementation requires a separately approved implementation plan and dedicated Pull Request.

## 2. Manager-first Decision Sequence

The Home Dashboard shall answer these questions in order:

1. What is abnormal?
2. How serious is it?
3. Which Utility systems are affected?
4. How long has the condition existed?
5. Is redundancy, availability, or reliability affected?
6. Does management action need to occur?

It is a management and engineering decision-support view, not a SCADA mimic. Raw sensor grids, process graphics, control commands, and detailed engineering analysis belong outside the Home Dashboard.

## 3. Proposed Information Hierarchy

### Level 1 — Immediate condition

1. **Overall Utility Health** — authoritative presented state, affected-system count, data confidence/freshness, and visible Simulated marker.
2. **Critical Alarm Summary** — critical, warning, and unacknowledged counts plus the latest major event and its age.
3. **Management attention queue** — concise ordered conditions requiring immediate, near-term, or monitoring action.

### Level 2 — Management impact

4. **Utility System Overview** — one comparable summary per system with state, most important management signal, active abnormality count, reliability indication, and freshness.
5. **Management KPI Summary** — a small catalogue of high-level availability, consumption, abnormality, maintenance, and freshness indicators.
6. **Equipment / Reliability Risk** — unavailable equipment, abnormal operation, degraded redundancy, overdue maintenance, and missing/stale monitoring.
7. **Work / Maintenance Summary** — PM due, overdue PM, open corrective actions, and major ongoing work as read-only summaries.

### Level 3 — Controlled drill-down

8. **Future module navigation** — clear links to future Utility-specific destinations without implementing those destinations or treating hidden navigation as authorization.

On desktop, Levels 1 and 2 should be visible with minimal scrolling at representative management resolutions. On mobile, Level 1 remains first and Level 2 becomes a concise stacked summary.

## 4. Utility System Overview Scope

| Stable system key | Presentation scope on Home Dashboard | Excluded detail |
|---|---|---|
| `electrical` | state, affected area/equipment count, supply/redundancy indication, freshness | single-line diagrams, breaker control, protection detail |
| `cda` | state, availability/redundancy indication, major abnormality, freshness | compressor sequencing, pressure trends, detailed assets |
| `di_ro` | state, availability, high-level production/consumption context, abnormality, freshness | water-quality analysis, train detail, control |
| `pcw` | state, availability/redundancy, major abnormality, freshness | loop hydraulics, equipment control, detailed temperatures |
| `chiller_cooling_tower` | state, plant availability/redundancy, major abnormality, freshness | staging logic, detailed efficiency and equipment screens |
| `ahu_hvac` | state, affected zone count, availability, major abnormality, freshness | room-by-room BMS mimic and control |
| `wwt` | state, availability, compliance-risk presentation, major abnormality, freshness | treatment control, laboratory or permit workflow |
| `energy` | state, high-level consumption context, abnormality, freshness | tariff optimization, billing, detailed metering analytics |

All keys remain canonical English identifiers. Display names and descriptions use centralized translation resources. The Home Dashboard shall not infer system state from translated text.

## 5. Candidate KPI and State Catalogue

### 5.1 Candidate management KPIs

| Canonical key | Management question | Minimum presentation metadata | Initial decision |
|---|---|---|---|
| `utility_availability` | Are essential Utility services available? | value, unit, period, source class, as-of time, quality/state | Candidate |
| `energy_consumption` | What is the current energy-consumption context? | value, unit, period, comparison basis, as-of time | Candidate; target not authoritative |
| `water_consumption` | What is the current water-consumption context? | value, unit, period, comparison basis, as-of time | Candidate; target not authoritative |
| `major_equipment_availability` | Is major equipment capacity available? | available/required count or ratio, scope, as-of time | Candidate |
| `active_abnormalities` | How many active conditions require attention? | count by severity, oldest age, affected systems | Required |
| `overdue_maintenance` | Is deferred maintenance increasing exposure? | overdue count, oldest age, affected systems | Candidate pending maintenance source |
| `data_freshness` | Can management trust the displayed view? | freshest/oldest timestamps, stale/unavailable counts | Required |

No proposed target, threshold, baseline, comparison period, formula, or service level is authoritative until separately owned, validated, and approved. The initial fixture may demonstrate shapes using conspicuously fictional values only.

### 5.2 Truthful state catalogue

| Canonical state | Meaning at presentation boundary |
|---|---|
| `normal` | No known condition requiring elevated attention within the supplied projection |
| `warning` | A supplied condition requires attention but is not supplied as critical |
| `critical` | A supplied condition requires immediate management attention |
| `unknown` | The supplying authority cannot determine a reliable state |
| `stale` | The projection is older than its supplied freshness policy allows |
| `unavailable` | The required projection cannot be supplied |
| `partial` | Some required contributing projections are unavailable or incomplete |
| `simulated` | The displayed record is fixture data and is not operational truth |

The Home Dashboard presents supplied states; it does not calculate freshness, alarm severity, authority, redundancy, or business priority. State aggregation rules belong to module-owned Application/Domain policies defined in later implementation work.

### 5.3 Reliability and work conditions

- `equipment_unavailable`
- `abnormal_operating_condition`
- `redundancy_degraded`
- `maintenance_due`
- `maintenance_overdue`
- `monitoring_stale`
- `monitoring_missing`
- `corrective_action_open`
- `major_work_in_progress`

These are candidate stable condition keys, not finalized domain schemas or workflow states.

## 6. Widget and Module Responsibility Map

| Home Dashboard region/widget | Home Dashboard responsibility | Owning authority / future port | Prohibited ownership |
|---|---|---|---|
| Overall Utility Health | compose and present supplied aggregate state and affected count | module-owned aggregate/read model | deriving plant health or freshness |
| Alarm Summary | present supplied counts, latest event, age, and drill-down target | future alarm Application port | alarm evaluation, acknowledgement, notification |
| Management Attention | order already-prioritized supplied attention items | module/application projection | inventing priority or action policy |
| Utility Overview Grid | register and present comparable module summaries | each Utility module owns its projection | direct adapter queries or utility calculations |
| KPI Summary | present approved KPI projections with provenance and period | KPI-owning module/application port | formulas, targets, or comparisons |
| Reliability Risk | present supplied equipment/redundancy risk summaries | asset/reliability application port | reliability inference or maintenance decisions |
| Work Summary | present supplied read-only counts and major-work context | future maintenance/work application port | CMMS, assignment, status transition, workflow |
| Navigation | expose registered visible future destinations | Dashboard Framework routing/navigation contracts | authorization or module implementation |

The Home Dashboard owns composition and management presentation only. Utility modules own meaning and source-specific adapters remain outside Experience code.

## 7. Simulated Data Boundary Proposal

The first implementation shall use **SIMULATED / FIXTURE DATA ONLY**.

### Required boundary

```text
Home Dashboard Experience
        ↓ supplied immutable projection
Home Dashboard Application read port
        ↓
Fixture adapter (initial implementation only)

Future adapters, separately authorized:
SCADA | BMS/FMS | manual input | maintenance | energy | external APIs
```

The initial adapter shall be replaceable and shall not establish a production schema. Experience code shall depend only on approved application projection contracts, never on vendor protocols or data-source payloads.

Each fixture projection shall include, as applicable:

- stable record and system keys;
- explicit `simulated` classification;
- source class such as `fixture`;
- observed/as-of timestamp and display timezone;
- freshness/state supplied by the owning projection;
- severity and acknowledgement state only when supplied;
- affected-system/equipment references using fictional identifiers;
- provenance/correlation metadata without sensitive data; and
- explicit unavailable, partial, stale, and error variants.

Fixture values, equipment names, alarms, timestamps, thresholds, and targets must be conspicuously fictional and must not be copied from a production factory.

## 8. Drill-down and Navigation Map

| Home Dashboard source | Future destination contract | Current proposal behavior |
|---|---|---|
| Overall Utility Health | cross-Utility condition view | route key reserved; destination not implemented |
| Alarm Summary / event | alarm overview or detail | route key reserved; no alarm module or acknowledgement |
| Utility card | corresponding Utility module landing screen | registered future destination only |
| KPI item | approved KPI/analysis screen | non-operational route contract only |
| Reliability risk | asset/reliability view | future destination only |
| Work summary | maintenance/work view | future destination only; no CMMS |

Candidate Utility route keys mirror the stable system keys in Section 4. Routing shall use Dashboard Framework contracts, preserve permission-aware visibility, and never treat an absent link as an access-control decision.

## 9. Multilingual Considerations

- Canonical code, state keys, system keys, API/application contracts, translation keys, and technical definitions remain English.
- Supported presentation locales are `ko-KR` — 한국어, `vi-VN` — Tiếng Việt, and `en-US` — English.
- All Home Dashboard user-facing text uses the centralized localization service and deterministic English fallback.
- Dates, times, numbers, percentages, quantities, and units use locale-aware presentation formatting while underlying engineering values remain locale independent.
- Alarm and engineering translations must preserve supplied technical meaning; translated labels never control logic.
- Cards, tables, badges, action labels, and mobile summaries shall tolerate Korean, Vietnamese, and English text expansion without fixed English-width assumptions.
- Fixture evidence shall demonstrate all three locales with Unicode-safe typography and no unnecessary external font dependency.
- Detailed Utility terminology catalogues remain future module responsibilities.

## 10. Responsive and Accessibility Requirements

### Desktop-first management view

- preserve the approved compact Experience Shell and command-center character;
- expose Level 1 conditions before lower-priority information;
- use a consistent dense grid with aligned comparisons and restrained whitespace;
- avoid decorative graphics, oversized typography, excessive gradients, and non-essential motion;
- keep alarm and state meaning distinguishable without color alone; and
- support rapid scanning with stable ordering and explicit timestamps/ages.

### Mobile summary

- keep compact navigation collapsed initially;
- present Overall Utility Health and critical/warning attention before system detail;
- collapse lower-priority KPI, reliability, and work sections progressively without hiding critical meaning;
- avoid page-level horizontal scrolling at 320 CSS pixels; and
- preserve drill-down labels, provenance, and simulated classification.

### Accessibility

- meet WCAG 2.2 AA requirements inherited from the Design System;
- maintain 44 × 44 CSS-pixel interaction targets, keyboard operation, logical focus order, visible focus, landmarks, headings, and meaningful link names;
- support 200% text zoom and applicable 400% reflow;
- support reduced motion and forced-colors/high-contrast behavior; and
- ensure counts, age, severity, acknowledgement, freshness, and simulated status are programmatically exposed rather than color-only.

Required responsive evidence widths remain 320, 375, 768, 1024, 1440, 1920, and 2560 CSS pixels.

## 11. Acceptance Criteria

The proposal is acceptable when:

1. the manager-first question sequence and three-level information hierarchy are approved;
2. all eight candidate Utility systems have a constrained comparable summary scope;
3. KPI candidates identify purpose, metadata, ownership needs, and non-authoritative target limitations;
4. truthful state and risk-condition keys are stable English concepts independent of translations;
5. widget responsibilities stop at composition/presentation and name their future application authority;
6. the initial data source is explicitly fixture-only with a replaceable application-port boundary;
7. simulated, stale, unavailable, partial, and failure cases are mandatory evidence states;
8. drill-down destinations are contracts/placeholders only and do not implement future modules;
9. `ko-KR`, `vi-VN`, and `en-US` requirements cover translation, formatting, text expansion, and Unicode;
10. desktop, mobile, keyboard, focus, zoom/reflow, high-contrast, reduced-motion, and semantic evidence requirements are explicit;
11. no production target, formula, alarm, source payload, or factory value is declared authoritative;
12. risks, dependencies, decisions, exclusions, and the separate implementation gate are recorded; and
13. independent QA finds no Critical or Major scope or architecture defect.

## 12. Explicitly Out of Scope

- Home Dashboard production or implementation code
- real or live SCADA, BMS/FMS, manual-input, maintenance, energy, or external API integration
- Gemma or other AI integration
- database schema, persistence implementation, or production API
- authentication or authorization implementation
- real alarms, alarm acknowledgement, notification, or escalation
- automatic control or equipment-control commands
- real KPI formulas, targets, thresholds, or calculations
- Utility-specific detailed screens or SCADA mimic graphics
- CMMS, workflow engine, assignment, or work-order lifecycle
- notification service
- production operational data or copied production identifiers
- production deployment, release, or promotion
- redesign of the approved Design System, Dashboard Framework, or Experience Shell architecture

## 13. Risks and Dependencies

| Risk or dependency | Impact | Required treatment |
|---|---|---|
| aggregate health lacks an approved owner/rule | misleading plant state | CTO/Utility Manager choose authority before implementation plan |
| alarm semantics and acknowledgement source are undefined | false urgency or incorrect counts | define future alarm port ownership and counting rules separately |
| KPI targets/formulas become accidental truth | unsafe management conclusions | fixture-only values; separately approve every formula/target |
| fixture contract becomes production schema | source coupling | mark temporary/versioned and depend on application projection ports |
| dashboard becomes a SCADA mimic | poor management usability | enforce manager-first hierarchy and raw-value exclusion |
| dense desktop view degrades mobile/accessibility | lost content or control | require responsive, semantic, zoom/reflow, keyboard, and assistive evidence |
| translation changes engineering meaning | inconsistent decisions | stable English keys; reviewed localized presentation only |
| stale or partial data appears normal | loss of trust | always expose freshness, provenance, and truthful degraded states |
| future module links imply implemented capability | misleading navigation | label fixture/future destinations and prevent dead production claims |
| maintenance summary implies CMMS ownership | scope expansion | read-only projection boundary; no workflow behavior |

Dependencies are the approved Physical Package Foundation, Design System Foundation Version 1.0.0, Dashboard Framework Version 1.0.0, centralized localization foundation, and future approval of module-owned projection contracts. No external adapter is a dependency for the fixture implementation.

## 14. Decisions Required Before an Implementation Plan

1. **Overall health authority:** Which module or cross-module policy owns overall Utility Health and affected-system aggregation?
2. **Alarm source semantics:** What counts as critical, warning, and unacknowledged, and which future authority supplies alarm age and latest-event selection?
3. **Initial KPI set:** Which candidates are mandatory in the first slice, and which must wait for approved source/formula ownership?
4. **System criticality/order:** Is the proposed eight-system order correct for management scanning, or should factory-specific criticality determine ordering?
5. **Management attention policy:** Should the first slice display supplied priorities only, or omit the attention queue until prioritization ownership is approved?
6. **Maintenance summary availability:** Should maintenance/work cards remain explicit unavailable fixtures until a maintenance source contract exists?
7. **Time basis:** Which plant timezone and age-display conventions shall be canonical for fixture review and future deployment?

## 15. Definition of Done

This Scope Proposal is Done only after CTO and Utility Manager approval records the decisions or accepted deferrals above, independent QA passes, and the proposal is merged as an approved version. Approval authorizes preparation of a dedicated implementation plan only. It does not authorize Home Dashboard code or any external integration.
