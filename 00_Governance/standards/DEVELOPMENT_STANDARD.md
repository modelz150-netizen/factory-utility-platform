# Development Standard

| Field | Value |
|---|---|
| Status | Active |
| Version | 1.0.0 |
| Owner | Engineering lead |
| Derived from | `../ARCHITECTURE.md` |

## Purpose

Define implementation rules for production-quality, maintainable software without duplicating architecture policy, documentation rules, QA gates, GitHub workflow, or release procedure.

## Platform and Structure

- WordPress is the primary platform; PHP, JavaScript, and CSS are the core technologies.
- Organize capabilities as cohesive modules with explicit public interfaces.
- Separate domain, application, presentation, data, integration, and platform concerns.
- Search for existing components, services, schemas, routes, utilities, and styles before creating new ones.
- Shared behavior belongs in a shared layer; feature-specific behavior remains within its module.
- External providers are accessed through replaceable adapters.

## Code Quality

- Prefer clear names, explicit behavior, and small testable units over clever abstractions.
- Avoid hidden global state, undocumented side effects, dead code, and speculative frameworks.
- Preserve backward compatibility unless a breaking change and migration are approved.
- Public interfaces and non-obvious invariants require documentation.
- Dependencies require justification, active maintenance, compatible licensing, and a removal path.

## Security and Error Handling

- Validate and sanitize data at trust boundaries and escape output for its destination.
- Use WordPress capabilities, nonces, prepared queries, and maintained APIs where applicable.
- Apply least privilege and deny unauthorized operations server-side.
- Do not commit credentials, secrets, personal data, or sensitive plant information.
- Provide explicit error handling, safe logging, and useful user-facing failure states.

## Experience Requirements

- Build mobile-first, responsive, semantic, and keyboard-operable interfaces.
- Meet WCAG 2.2 AA as the accessibility target.
- Reuse approved design tokens and components.
- Provide loading, empty, validation, error, success, and permission states where applicable.
- Load assets only where required and avoid duplicated libraries.

## Engineering Data Rules

- Define formula variables, units, ranges, assumptions, precision, provenance, and known-answer examples.
- Never perform silent unit conversions.
- Separate general reference guidance from regulatory, vendor, and site-specific requirements.
- Treat calculation correctness and source traceability as domain invariants.

## Completion

Implementation is complete only when applicable documentation, tests, QA evidence, backlog status, and changelog entries are current. Detailed verification requirements are owned by `QA_STANDARD.md`.
