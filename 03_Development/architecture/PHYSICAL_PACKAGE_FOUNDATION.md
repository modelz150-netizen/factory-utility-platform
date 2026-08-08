# Physical Package Foundation

| Field | Value |
|---|---|
| Status | Review |
| Version | 0.1.0 |
| Date | 2026-08-08 |
| Backlog | `ARC-001` |
| Owner | Engineering lead |
| Authority | [Physical WordPress Package Architecture](PHYSICAL_WORDPRESS_PACKAGE_ARCHITECTURE_PROPOSAL.md) |

## Purpose

Define and implement the smallest compile-safe physical foundation for the approved WordPress-hosted modular monolith. This foundation proves package placement, namespace ownership, composition-root behavior, and enforceable dependency direction without introducing a Product feature.

## Deployable Boundary

`03_Development/platform` is the single Platform plugin/package root. `factory-utility-platform.php` is the WordPress entry file, and `src/Platform/Bootstrap/Plugin.php` is the only composition root. The entry file may depend on WordPress host conventions and the composition root; core packages shall not depend on WordPress globals.

## Namespace and Directory Map

| Namespace | Directory | Responsibility |
|---|---|---|
| `FactoryUtility\Platform\` | `src/Platform` | composition root and lifecycle-neutral Platform bootstrap |
| `FactoryUtility\Modules\` | `src/Modules` | module contracts and future cohesive module packages |
| `FactoryUtility\Experience\` | `src/Experience` | future delivery and presentation contracts |
| `FactoryUtility\Adapters\` | `src/Adapters` | WordPress and future provider-facing adapter implementations |
| `FactoryUtility\Shared\` | `src/Shared` | admitted cross-cutting contracts only |
| `FactoryUtility\Tests\` | `tests` | unit, contract, and architecture fitness tests |

Each future feature module owns `Domain`, `Application`, and `Infrastructure` beneath `src/Modules/<Module>`. The committed `ModuleTemplate` directories document that shape but contain no runtime module or Product behavior.

## Tooling Decisions

- PHP 8.2 is the minimum runtime for typed, maintained Platform code.
- Composer owns PSR-4 autoloading and development-tool execution.
- PHPUnit executes unit and architecture fitness tests.
- PHPStan at maximum rule level provides static analysis for the foundation.
- A repository-owned PHPUnit architecture test enforces dependency rules without making architecture authority dependent on a third-party layering framework.

These tools are replaceable development dependencies. They do not change the approved logical architecture or select a production host, persistence provider, integration provider, schema, API, or deployment platform.

## Enforced Dependency Rules

- namespaces must match their PSR-4 directory boundary;
- Domain code must not depend on Application, Infrastructure, Experience, Adapters, Bootstrap, WordPress, or provider symbols;
- Application code must not depend on Infrastructure, Experience, Adapters, Bootstrap, or WordPress symbols;
- Experience code must not depend directly on module Domain or Infrastructure types;
- WordPress global functions are prohibited in Domain and Application packages;
- module-to-module internal imports are prohibited; future collaboration requires public module contracts; and
- the composition root contains assembly only and no Product behavior.

## Explicit Exclusions

This foundation contains no Dashboard UI, Design System implementation, business rule, formula, persistence or database schema, authentication, API, SCADA or AI integration, widget, operational feature, production configuration, or deployment automation.

## Validation and Promotion Gate

The foundation remains in Review until Composer validation, autoload generation, PHPUnit, dependency fitness tests, PHPStan, link validation, scope inspection, and independent architecture review are recorded in QA evidence. Approval of this foundation is required before Design System work begins.
