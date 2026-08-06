# Product Charter

| Field | Value |
|---|---|
| Product | Factory Utility Platform |
| Status | Active |
| Version | 1.0.0 |
| Effective date | 2026-08-05 |
| Owner | Product owner |
| Derived from | [Master Project Charter](../MASTER_PROJECT_CHARTER.md) and approved Governance architecture |

## Product Mission

Build a dependable engineering platform that helps semiconductor and industrial utility engineers calculate, reference, diagnose, monitor, and improve utility systems. The product is an operational engineering platform, not a content-only blog.

## Primary Users

- Semiconductor utility engineers
- Industrial facility and plant utility engineers
- Reliability, maintenance, energy, and operations engineers
- Engineering managers responsible for technical governance and performance

## Product Scope

- Home Dashboard
- Engineering Calculator
- Engineering Reference
- Trouble Guide
- Equipment Library
- Vendor Library
- AI Copilot
- SCADA Dashboard
- Energy and Carbon Management

## Product Outcomes

- Engineers can trust calculations and trace formulas, assumptions, units, and sources.
- Engineers can find structured reference and troubleshooting information efficiently.
- Shared equipment, vendor, and engineering data can be reused across product modules.
- Operational and energy information can be presented through governed integration boundaries.
- AI assistance can use approved project knowledge with citations, permissions, and uncertainty handling.

## Current Product Phase

Sprint 1 establishes the shared foundation for project architecture, dashboard framework, calculator framework, reference framework, design system, and documentation system.

Production SCADA integrations, production AI Copilot operations, final vendor marketplace workflows, large-scale migration, and unapproved third-party commitments remain outside Sprint 1 implementation scope.

## Product Constraints

- WordPress is the primary platform unless an approved architecture decision changes it.
- PHP, JavaScript, and CSS are the core implementation technologies.
- Mobile use, accessibility, security, SEO, performance, and long-term maintainability are first-class requirements.
- Product capabilities must use reusable components and must not duplicate existing behavior.

## Success Principles

- Trusted engineering data
- Reusable product capabilities
- Mobile-first usability
- Secure and accessible operation
- Observable quality and performance
- Sustainable evolution without duplicated logic
