# Design System Foundation

| Field | Value |
|---|---|
| Status | Active |
| Version | 1.0.0 |
| Date | 2026-08-09 |
| Backlog | `DES-001` |
| Owner | Product Design with Accessibility, Engineering, and QA sign-off |
| Authority | [Implementation Plan](../DESIGN_SYSTEM_FOUNDATION_IMPLEMENTATION_PLAN.md) |
| Approval | CTO-approved through PR #39 on 2026-08-09 |

## Contract

The foundation supplies presentation-only tokens, CSS, icons, and low-level primitives. It accepts explicit state and content; it does not infer authority, freshness, access, or domain meaning. Domain and Application code remain independent of it. WordPress does not register the fixture and does not own tokens.

## Token Layers

`tokens.json` is the source of truth. Primitive tokens contain raw scales, semantic tokens express durable intent, and component aliases narrow a shared primitive without duplicating its value. Run `composer tokens:generate` after an approved source change; CI uses `composer tokens:check` to detect drift.

## Primitive Catalog

| Primitive | Lifecycle | Purpose | Key accessibility contract | Forbidden use |
|---|---|---|---|---|
| Shell, container, stack, cluster, grid | Active | Structural layout | DOM order remains reading/focus order | Dashboard routing or authorization |
| Skip link, link, button | Active | Navigation and actions | 44×44 target for buttons; visible focus; accessible name | Domain actions or hidden labels |
| Field, input, select, textarea | Active | Native form structure | Explicit label, hint/error association, invalid state | Validation/business rules |
| Status | Active | Present an explicit state | Text and shape in addition to color | Freshness calculation or authority inference |
| Panel | Active | Generic grouping | Heading/landmark chosen by consumer | Widget or domain semantics |
| Table wrapper | Active | Narrow-width containment | Caption, headers, named scroll region | Hiding columns without an alternative |
| Dialog | Active | Native modal surface | Focus enters, Escape closes, focus returns | Workflow or authorization policy |
| Visually hidden, numeric data | Active | Accessibility and formatting helpers | Content remains available to assistive technology | Concealing interactive controls |

Supported presentation states are neutral, information, success, warning, critical, unknown, loading, empty, partial, stale, unavailable, and simulated. Consumers must supply truthful labels and any required source or timestamp disclosure.

## Responsive and Theme Boundaries

The CSS is mobile-first and validated at 320, 375, 768, 1024, 1440, 1920, and 2560 CSS pixels. The structural desktop change occurs at 1024px; content remains one-column before that. Light semantic tokens are the only active theme. Future themes may override semantic tokens at one root attribute only after their own contrast evidence.

## Assets and Fixtures

Icons are first-party, use a 24-unit view box, inherit `currentColor`, and are listed in the manifest. The fixture under `tests/Fixtures/DesignSystem` contains fictional values visibly marked Demo or Simulated. It is test-only, has no external calls, and is not loaded by the WordPress composition root.
