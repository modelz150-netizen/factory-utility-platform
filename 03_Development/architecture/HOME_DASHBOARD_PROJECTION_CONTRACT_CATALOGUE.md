# Home Dashboard Projection Contract Catalogue

| Field | Value |
|---|---|
| Status | Active / Approved |
| Version | 1.0.0 |
| Backlog | `DASH-003` |

This catalogue defines implementation-neutral Application projection contracts. Field names are canonical English concepts; concrete PHP names may be refined without weakening semantics. No contract authorizes a database or external integration.

## Common projection envelope

Every page region carries:

| Field | Meaning |
|---|---|
| `contractVersion` | Explicit projection schema version |
| `projectionId` | Fiction-safe correlation identifier, not a production equipment identifier |
| `state` | Stable truthful state key |
| `simulation` | Boolean; always `true` in this vertical slice |
| `sourceClass` | Stable source classification such as `fixture` or future adapter class |
| `observedAt` / `asOf` | Preserved source and projection instants |
| `sourceTimezone` | Original zone/offset provenance when supplied |
| `plantTimezone` | `Asia/Ho_Chi_Minh` |
| `freshness` | Supplied state, age/duration, and threshold-policy reference |
| `quality` | Supplied completeness/trust classification and limitations |
| `messageKey` / `parameters` | Optional centralized presentation message without localized behavior |

`simulated` is orthogonal to operational state: a simulated item may also be `critical`, `stale`, or `partial`.

## Page read contract

`HomeDashboardReadPort` accepts plant context, requested locale-independent instant, and optional fixture scenario identity. It returns one immutable `HomeDashboardProjection` containing the regions below in deterministic semantic order. Partial region failures are represented, not thrown through to Experience.

## Overall Utility Health projection

- aggregate state;
- affected Utility keys and affected count;
- contributing Utility state references;
- policy identifier and version;
- completeness/freshness/provenance envelope;
- concise condition key and parameters.

Invariant: the `overall-health/1.0` precedence is Critical, Warning, all-unavailable, missing/unavailable/unknown, stale, then Normal-only-completeness, exactly as defined by the Implementation Plan. Operational severity and freshness are separate dimensions, so stale Critical remains Critical with a stale limitation. The projection cannot be constructed with a lower aggregate while declaring a higher-precedence contributor. Experience cannot construct this projection from cards.

## Alarm Summary projection

- `criticalCount`, `warningCount`, `unacknowledgedCount` as supplied non-negative counts or unavailable values;
- latest major event: event reference, severity key, affected Utility key, condition key/parameters, source instant, duration-based age;
- affected Utility keys;
- envelope and limitations.

Zero is valid only when an authoritative supplied result says zero; missing data is `unavailable`, never zero. No alarm evaluation or acknowledgement command is included.

## Management Attention projection

The contract contains an already-prioritized ordered list. Each item carries:

- stable item reference and supplied rank/order;
- severity and affected Utility keys;
- concise condition key/parameters;
- start/source instant and duration-based age;
- reliability impact and redundancy state;
- management-attention category key;
- freshness/provenance;
- optional future route identifier, never a fabricated destination.

Presentation preserves order. No priority score or Experience comparator exists.

## Utility Summary projection

One shared shape serves these configured keys and initial order:

1. `electrical`
2. `cda`
3. `di_ro`
4. `pcw`
5. `chiller_cooling_tower`
6. `ahu_hvac`
7. `wwt`
8. `energy`

Fields: Utility key, supplied display order, operational state, affected-condition count, availability state/value when supplied, redundancy state, management headline key/parameters, active Critical/Warning counts when authoritative, freshness/provenance, and future route identifier. Raw sensor series are excluded.

## P0 KPI projections

Common KPI fields: stable KPI key, display value or unavailable marker, unit key, period/start/end, state, quality, source/formula-policy reference, freshness, and simulation disclosure.

Required P0 keys:

- `utility_availability`
- `active_abnormalities`
- `major_equipment_availability`
- `data_freshness`

Values and formula results are supplied. The contract does not define targets, thresholds, or Experience calculations.

## P1 KPI placeholder projections

Keys are `energy_consumption` and `water_consumption`. Each is either a supplied simulated KPI projection or a placeholder with `unavailable` / `not_configured`, reason key, and source limitation. A placeholder has no invented numeric value or target.

## Reliability Risk projection

Ordered supplied items may classify `equipment_unavailable`, `abnormal_operating_condition`, `redundancy_degraded`, `maintenance_overdue`, or `monitoring_data_risk`. Each includes severity, Utility, asset reference safe for fixtures, condition, duration, reliability/redundancy impact, freshness, and provenance. Diagnosis and risk scoring are absent.

## Work / Maintenance projection

Optional supplied counts/context cover PM due, overdue PM, open corrective actions, and major ongoing work. The authority state is mandatory. Without an authoritative contract, the projection is explicitly `simulated` or `unavailable`; it cannot appear operationally authoritative. No task mutation, workflow, assignment, or CMMS identifier is included.

## Validation rules

- enums reject unknown behavior keys but permit a controlled `unknown` state;
- counts cannot be negative;
- absolute instants retain offset/zone provenance;
- duration is non-negative and clock-testable;
- affected count agrees with unique affected keys;
- Utility keys are unique and configured order is deterministic;
- all fixture projections carry `simulation: true` and `sourceClass: fixture`;
- localized text, HTML, source clients, and framework objects are rejected from Application contracts.
