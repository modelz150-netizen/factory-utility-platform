# ADR-001 — Platform Architecture Style Proposal

| Field | Value |
|---|---|
| Status | Proposed |
| Date | 2026-08-06 |
| Backlog | `ARC-003` |
| Decision owner | Chief architect |
| Scope | Platform architecture style and WordPress dependency boundary |
| Supersedes | None |
| Decision | Not effective until CTO approval |

## Context

Factory Utility Platform requires a WordPress-first architecture that can deliver a responsive MVP while supporting long-term Calculator, Reference, Knowledge, Asset, Reports, AI, SCADA, and Energy capabilities. The architecture must avoid feature silos, WordPress-global coupling, premature distributed systems, and provider lock-in.

The decision must balance present delivery simplicity with future separation of high-consequence or independently scaling integrations.

## Decision Drivers

- ten-year maintainability and clear ownership;
- reusable module boundaries and shared services;
- WordPress-first delivery using PHP, JavaScript, and CSS;
- mobile-first, accessible, secure, performant, and SEO-capable experiences;
- traceable engineering data, units, sources, and validation;
- future API, AI, SCADA, energy, asset, and reporting expansion;
- provider and hosting portability;
- proportional operational complexity; and
- a safe migration path without premature distribution.

## Option A — WordPress Plugin/Package-Centric Architecture

### Description

Product capabilities are organized primarily as WordPress plugins, packages, hooks, routes, content types, and platform conventions. WordPress is both runtime host and dominant application boundary.

### Strengths

- lowest initial deployment and operational complexity;
- direct use of mature WordPress lifecycle, permissions, content, caching, and administration;
- familiar implementation model and straightforward MVP packaging; and
- good compatibility with server-rendered SEO and content stewardship.

### Weaknesses

- high risk that domain rules depend on WordPress globals and persistence concepts;
- plugin boundaries may become technical packaging rather than cohesive domain boundaries;
- shared services may be duplicated or hidden in common utility code;
- future SCADA, AI, or API extraction becomes costly; and
- testing outside the WordPress runtime becomes harder.

### Best fit

Small content-led products with limited domain complexity and little expectation of provider-independent integration.

## Option B — Modular Monolith

### Description

The Platform is one deployable application with cohesive modules, explicit public contracts, inward dependency direction, and shared services. WordPress is the runtime host and adapter rather than the owner of core domain behavior.

### Strengths

- one deployment and transaction boundary for the MVP;
- enforceable module ownership without distributed-system overhead;
- domain and application logic can be tested independently of WordPress globals;
- shared services remain explicit and reusable;
- module extraction remains possible where evidence later justifies it; and
- fits the current team and infrastructure maturity.

### Weaknesses

- boundaries can erode without automated dependency checks and ownership discipline;
- one deployment couples release cadence and resource scaling initially;
- poorly governed shared services can become a miscellaneous layer; and
- WordPress packaging requires deliberate bootstrap and adapter design.

### Best fit

A long-term Product needing strong internal modularity, one initial deployment, and future expansion without premature distribution.

## Option C — Hybrid Architecture

### Description

Core Product capabilities remain in WordPress while selected services or integrations run as separately deployable components from the beginning.

### Strengths

- independent scaling and isolation for operational or compute-heavy workloads;
- stronger network separation for SCADA and AI boundaries;
- technology choice can vary by responsibility; and
- independent Release cadence for selected integrations.

### Weaknesses

- immediate network, identity, deployment, observability, consistency, and failure-mode complexity;
- higher operational and security burden before live integrations are authorized;
- duplicated contracts and distributed data ownership risk; and
- difficult local development and testing for an early-stage Platform.

### Best fit

Mature workloads with proven independent scaling, security-zone, reliability, or organizational requirements.

## Evaluation

| Criterion | Plugin/package-centric | Modular monolith | Hybrid |
|---|---:|---:|---:|
| MVP simplicity | High | High | Low |
| Enforceable domain boundaries | Low–Medium | High | High |
| WordPress portability | Low | High | High |
| Operational simplicity | High | High | Low |
| Future API/SCADA/AI expansion | Medium | High | High |
| Testability outside WordPress | Low | High | High |
| Migration safety | Medium | High | Medium |
| Current proportionality | Medium | High | Low |

## Proposed Decision

Adopt a **WordPress-hosted modular monolith with hybrid-ready integration boundaries**.

This means:

1. the MVP is one deployable WordPress-integrated Platform package or coordinated package set;
2. internal modules are cohesive and communicate only through explicit application and domain contracts;
3. WordPress hooks, globals, persistence, routing, and capabilities are isolated in Platform adapters;
4. AI, SCADA, vendor, analytics, and future external APIs enter through replaceable integration ports;
5. no external service is created until an ADR demonstrates a justified scaling, security-zone, reliability, technology, or ownership requirement; and
6. module extraction preserves the existing contract and is treated as migration, not redesign by default.

## Module Boundaries

The initial modular monolith shall distinguish:

- Experience Shell and Dashboard composition;
- Utility Domain modules;
- Engineering Calculator;
- Engineering Reference and Knowledge;
- Asset, Alarm, and Maintenance context;
- Energy and Reports;
- AI orchestration boundary;
- SCADA operational observation boundary;
- Shared Domain Services; and
- WordPress and external Integration adapters.

A module owns its domain concepts, application use cases, internal persistence mapping, and feature presentation. It exposes a small public contract and shall not reach into another module's internal storage or WordPress implementation.

## Shared Services

Shared services are limited to genuinely cross-cutting responsibilities:

- units and measurement context;
- provenance, citations, revision, and validation state;
- identity and authorization contracts;
- search contracts;
- logging, correlation, metrics, and audit events;
- caching abstractions;
- configuration contracts; and
- design primitives and shared page states.

Feature-specific logic shall not be moved into Shared merely to bypass ownership.

## Deployment Boundaries

Initially:

- responsive clients communicate with one approved WordPress web boundary;
- Platform modules execute within the WordPress application deployment;
- persistence is accessed only through approved repositories and adapters; and
- future integrations remain disabled seams.

Future integration services may become separate deployments only after a dedicated ADR defines trust zones, network contracts, failure behavior, observability, security, ownership, deployment, recovery, and migration.

## WordPress Dependency Boundaries

- Domain code shall not depend on WordPress globals, hooks, request objects, database APIs, or content-type identifiers.
- Application use cases may depend on Platform-owned ports, not concrete WordPress APIs.
- WordPress adapters translate hooks, capabilities, routing, persistence, caching, localization, and administration into Platform contracts.
- Theme responsibilities shall remain presentational; Product behavior belongs in governed Platform modules.
- WordPress upgrades or replacement shall not require rewriting core engineering rules.

## Future API and SCADA Expansion

Application use cases may later be exposed through approved APIs without moving domain logic into transport controllers. API shape, authentication, versioning, and code are not decided here.

SCADA integration shall remain a separate, read-oriented adapter boundary. A future gateway or integration service may be extracted when network zoning, availability, throughput, protocol, or safety evidence requires it. No live connection or control path is authorized.

## Maintainability and Migration Risks

| Risk | Mitigation or required evidence |
|---|---|
| Module boundaries erode | Dependency rules, public-contract review, ownership, and architecture tests before implementation |
| Shared services become a dumping ground | Admission criteria and accountable service ownership |
| WordPress leaks into domain code | Static dependency checks, adapter tests, and code-review gates |
| One deployment becomes a scaling bottleneck | Observe workload evidence before extracting a module |
| Premature extraction creates distributed complexity | Require a dedicated ADR and migration plan |
| Contract changes break future consumers | Version and compatibility policy before external API exposure |
| Persistence ownership is ambiguous | Define logical ownership in Platform Architecture before physical schema work |
| SCADA or AI bypasses the Platform boundary | Prohibit direct module/provider calls and validate adapter use |

## Consequences if Approved

### Positive

- MVP delivery remains operationally simple.
- Long-term domain and provider portability are protected.
- Shared services and module ownership become explicit.
- Hybrid evolution remains possible through evidence-driven extraction.

### Costs

- architecture and dependency rules must be defined before feature code;
- WordPress adapters require more discipline than direct global calls; and
- module boundaries require continued review and validation.

## Rejected as Initial Style

- Pure plugin/package-centric architecture is rejected because WordPress coupling and domain fragmentation risks are too high.
- Hybrid distributed architecture is rejected as the initial style because no current workload or live integration justifies its operational complexity.

## Approval Gate

This ADR is Proposed. It does not authorize package creation, schema, API, service extraction, live integration, production deployment, or Dashboard implementation. The decision becomes effective only after CTO approval and merge.
