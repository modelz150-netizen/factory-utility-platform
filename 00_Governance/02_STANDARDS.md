# Project Standards

| Field | Value |
|---|---|
| Status | Active |
| Version | 1.0.0 |
| Effective date | 2026-08-05 |

## Architecture

- WordPress is the primary application platform.
- Use PHP for server-side domain and WordPress integration code, JavaScript for interactive behavior, and CSS for presentation.
- Organize features as cohesive modules with explicit public interfaces.
- Separate domain rules, data access, presentation, and infrastructure concerns.
- Search for an existing capability before introducing a component, utility, endpoint, schema, or style pattern.
- Shared behavior belongs in a shared layer; feature-specific behavior stays inside its module.
- Dependencies must be justified, maintained, and compatible with the project license and deployment environment.

## Code Quality

- Prefer clear names and small, testable units over clever abstractions.
- Validate and sanitize input at trust boundaries; escape output for its destination context.
- Use WordPress APIs and conventions where they provide secure, maintained behavior.
- Include explicit error handling and useful user-facing failure states.
- Avoid hidden global state and undocumented side effects.
- Document public interfaces, engineering formulas, non-obvious decisions, and configuration requirements.
- Preserve backward compatibility unless a breaking change is approved and documented.

## UI and Design

- Design mobile-first and verify common mobile, tablet, and desktop states.
- Reuse tokens and components from the design system.
- Meet WCAG 2.2 AA as the accessibility target.
- Support keyboard navigation, visible focus, semantic markup, and meaningful labels.
- Prevent layout shifts and avoid unnecessary client-side work.
- Provide loading, empty, error, validation, and success states where applicable.

## Engineering Data

- Every formula must define variables, units, valid ranges, assumptions, source, and expected precision.
- Use explicit units and avoid silent unit conversion.
- Test boundary values, invalid values, conversions, and representative known answers.
- Clearly distinguish reference guidance from regulatory or site-specific requirements.

## Security and Privacy

- Apply least privilege and WordPress capability checks.
- Use nonces where WordPress request protection requires them.
- Do not commit credentials, private keys, personal data, or production secrets.
- Minimize stored personal and operational data and document retention requirements.
- Log failures without exposing secrets or sensitive plant information.

## Performance and SEO

- Load assets only where needed and avoid duplicate libraries.
- Prefer server-rendered, semantic content for indexable reference material.
- Define measurable performance budgets before production release.
- Use stable URLs, meaningful metadata, and structured data only when valid for the content.
- Optimize images and cache deterministic reference data appropriately.

## Documentation and File Placement

- Governance decisions go in `00_Governance`.
- Requirements and acceptance criteria go in `01_Product`.
- Validated domain knowledge and formulas go in `02_Engineering`.
- Source and development documentation go in `03_Development`.
- Design artifacts go in `04_Design`.
- Test plans and executed results go in `05_QA`.
- Business and release artifacts go in their respective folders.
- Source conversations and general research go in `99_Knowledge` and must not replace approved requirements.

## Change Control

- Associate each material change with a backlog ID.
- Update backlog status and changelog in the same change set.
- Record architecture decisions that create durable constraints.
- Do not delete working files without explicit user approval.
- Flag migrations, compatibility impacts, operational risks, and rollback requirements before release.

## Testing

- Choose unit, integration, end-to-end, accessibility, security, and performance checks according to risk.
- Store executed test evidence in `05_QA` with date, environment, scope, commands or method, results, and known gaps.
- A missing test environment must be reported as a gap, never represented as a pass.
