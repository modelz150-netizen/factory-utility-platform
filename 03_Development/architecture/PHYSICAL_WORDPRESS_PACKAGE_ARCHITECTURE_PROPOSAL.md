# Physical WordPress Package Architecture Proposal

| Field | Value |
|---|---|
| Status | Review |
| Version | 0.1.0 |
| Date | 2026-08-06 |
| Backlog | `ARC-001`, `ARC-005` |
| Owner | Chief architect |
| Authority | [Platform Architecture v1.0](PLATFORM_ARCHITECTURE_V1.md) |

## Purpose

Define the physical packaging rules needed to implement the approved WordPress-hosted modular monolith without coupling core domain or application logic to WordPress globals. Approval authorizes a later physical design, not code scaffolding.

## Proposed Package Model

One versioned Platform plugin/package shall act as the deployable composition root. Its internal packages shall follow these responsibilities:

| Package boundary | Responsibility | Allowed dependencies |
|---|---|---|
| `Platform/Bootstrap` | composition root, lifecycle registration, adapter selection | all public contracts and adapters |
| `Experience` | delivery contracts, navigation and composition | Application contracts and design primitives |
| `Modules/<Module>/Domain` | module policy, value objects and invariants | language/runtime and narrow shared domain contracts only |
| `Modules/<Module>/Application` | use cases and ports | own Domain and approved shared contracts |
| `Modules/<Module>/Infrastructure` | persistence and provider adapters | own Application ports and host APIs |
| `Adapters/WordPress` | hooks, routing, content, admin, identity and cache translation | WordPress and Application ports |
| `Platform/Shared` | units, provenance, access context, time, configuration, observability contracts | no feature implementation |
| `Tests` | contract, dependency, module and adapter validation | public contracts and test fixtures |

Namespaces, directories, autoloading, build tooling and WordPress entry files remain open physical-design decisions. Package names above express responsibilities, not an authorized filesystem scaffold.

## Dependency Rules

- Domain shall not reference WordPress functions, globals, database concepts, HTTP transports or provider SDKs.
- Application may depend on its Domain and declared shared contracts; it shall expose ports for infrastructure needs.
- Infrastructure and WordPress adapters implement inward-facing ports.
- Modules shall not read or mutate another module's private storage or classes.
- Cross-module use shall occur through stable application contracts or governed immutable events.
- Bootstrap is the only composition root and shall not contain business policy.
- Automated dependency checks shall fail prohibited edges before implementation is considered complete.

## WordPress Boundary

WordPress remains the runtime host for boot, web delivery, administration, content and infrastructure integration. The theme remains presentation-only. WordPress-specific representations shall be translated at adapters and shall not become core domain types.

## Acceptance Criteria

- one deployable boundary and one composition root are defined;
- module Domain, Application and Infrastructure responsibilities are distinguishable;
- prohibited dependency edges are mechanically testable;
- shared services have owners and admission criteria;
- host replacement does not require rewriting domain policy;
- plugin/theme responsibilities do not overlap; and
- no code, schema, provider or deployment implementation is introduced.

## Risks and Open Decisions

| Risk or decision | Required disposition before implementation |
|---|---|
| package granularity becomes excessive | prove each boundary protects cohesive ownership or an independent test seam |
| shared package becomes a utility dump | publish admission and ownership rules before scaffolding |
| WordPress hooks leak inward | define adapter contracts and dependency fitness tests |
| packaging conflicts with PHP tooling | approve namespace, autoload and build conventions separately |
| persistence coupling blocks module evolution | define module-owned persistence ports before schema work |

## Definition of Done

The proposal is complete when QA and CTO approve the boundary model, dependency rules, acceptance criteria, risks and deferred decisions. Implementation remains blocked until a subsequent physical design artifact identifies exact packages, tests and migration constraints.
