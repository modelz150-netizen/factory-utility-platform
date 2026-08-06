# First Vertical Slice Proposal

| Field | Value |
|---|---|
| Status | Review |
| Version | 0.1.0 |
| Date | 2026-08-06 |
| Backlog | `ARC-005` |
| Owner | Lead engineer with Product, Design and QA review |
| Authority | [Platform Architecture v1.0](PLATFORM_ARCHITECTURE_V1.md) |

## Purpose

Propose the smallest end-to-end, fixture-based slice that can prove the approved architecture before production Dashboard implementation. The slice is an architecture experiment and review artifact, not a production feature.

## Proposed Slice

An accessible Home Dashboard shell presents approved static fixture content, utility-module navigation, and entry links for Engineering Calculator and Reference. One non-operational utility summary panel demonstrates composition, module ownership, provenance, timestamp and explicit `Simulated` state through a replaceable in-memory adapter.

## Boundaries

The slice may later exercise Experience → Application → Domain and adapter direction, WordPress host bootstrapping, design primitives, Dashboard registration, fixture projection, observability and responsive states. It shall not ingest live data or define formulas, schemas, authentication, external APIs, AI behavior, SCADA protocols or production deployment.

## Acceptance Criteria

- the slice uses one module-owned application contract and an in-memory fixture adapter;
- the UI visibly identifies fixture data as simulated and never operational;
- WordPress-specific code remains outside Domain and Application packages;
- keyboard, focus, 320-pixel reflow and WCAG 2.2 AA smoke criteria pass;
- navigation exposes the approved MVP entries without implementing their features;
- unavailable and error states are independently demonstrable;
- correlation and failure evidence are observable without sensitive data; and
- all code, if later authorized, is disposable or promotable only through a separate production review.

## QA Strategy

Future slice validation shall combine dependency fitness tests, application contract tests, adapter tests, semantic and keyboard checks, representative responsive evidence, performance budgets, simulated-state truthfulness, failure-isolation tests and a manual architecture review. Passed, failed, skipped and not-applicable evidence shall remain distinct.

## Risks and Open Decisions

| Risk or decision | Required disposition |
|---|---|
| experiment is mistaken for production | watermark simulated data and require explicit promotion gate |
| slice chooses architecture by convenience | implement only after physical and design boundaries are approved |
| fixture shape becomes an accidental schema | treat fixture contract as temporary and versioned |
| WordPress dominates the slice | validate core use case independently of the host |
| too much MVP scope enters the experiment | limit to Shell, navigation, entries and one simulated panel |

## Definition of Done

The proposal is complete when the testable hypothesis, slice boundary, acceptance criteria, QA evidence model, risks and promotion prohibition are approved. No slice implementation is authorized by this proposal.
