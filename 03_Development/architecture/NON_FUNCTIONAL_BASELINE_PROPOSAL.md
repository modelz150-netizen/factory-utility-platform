# Platform Non-functional Baseline Proposal

| Field | Value |
|---|---|
| Status | Review |
| Version | 0.1.0 |
| Date | 2026-08-06 |
| Backlog | `ARC-003` |
| Owner | Chief architect with QA, Security, Accessibility, and Operations review |
| Applies to | Platform foundation and first Dashboard MVP when separately authorized |

## Purpose

Define measurable minimum quality targets that Platform Architecture v1.0 and later implementation must design for. These are proposal-stage engineering budgets, not evidence that a production system currently meets them.

## Measurement Principles

- Results shall identify environment, workload, dataset, device or browser, network profile, sample count, percentile, and tool.
- Passed, failed, skipped, unavailable, and not applicable remain distinct.
- Field measurements take precedence for operational truth when sufficient data exists; controlled laboratory measurements remain required before field evidence is available.
- Public, authenticated, administrative, and future operational paths may receive different budgets only through an approved risk-based decision.
- Critical user journeys and high-consequence information receive stronger validation than decorative or infrequent behavior.

## 1. Performance

### User experience targets

Measured at the 75th percentile for supported mobile and desktop clients:

| Metric | Target | Initial measurement condition |
|---|---:|---|
| Largest Contentful Paint | ≤ 2.5 seconds | Representative production-like page, mobile 4G profile and desktop broadband |
| Interaction to Next Paint | ≤ 200 milliseconds | Critical navigation and Dashboard interactions |
| Cumulative Layout Shift | ≤ 0.10 | Full page lifecycle |
| Time to First Byte | ≤ 800 milliseconds | Cache-eligible public pages at normal load |
| Time to First Byte | ≤ 1.5 seconds | Uncached or personalized MVP request at normal load |
| Critical navigation response | ≤ 1.0 second perceived response or immediate progress state | Module navigation and entry actions |

### Resource budgets

- initial route JavaScript: ≤ 200 KB compressed, excluding separately justified visualization libraries;
- initial route CSS: ≤ 100 KB compressed;
- critical-font transfer: ≤ 150 KB compressed;
- no duplicate runtime or library bundle;
- images use responsive sizing and modern formats where supported; and
- every third-party script requires purpose, budget, privacy, failure, and removal review.

Performance exceptions require evidence, affected journeys, owner, compensating action, and expiry or remediation.

## 2. Availability and Reliability

| Measure | Baseline target |
|---|---:|
| Monthly web availability after production launch | ≥ 99.5%, excluding approved maintenance |
| Unhandled server-error rate | < 0.5% of requests per rolling 30 minutes under normal load |
| Critical navigation success | ≥ 99.9% under validated normal conditions |
| Data-state truthfulness | 100% of unavailable, stale, partial, or simulated data states visibly identified |
| Scheduled maintenance notice | Recorded with owner, window, affected scope, and recovery validation |

The MVP shall degrade to safe navigation and truthful content states where optional modules fail. Failure of future AI, SCADA, analytics, or external sources shall not take down the core Reference or Calculator entry paths unless an approved dependency explicitly requires it.

## 3. Responsiveness

- supported viewport width: 320 CSS pixels through 2560 CSS pixels;
- no required horizontal page scrolling at 320 CSS pixels, except an explicitly contained data visualization with an accessible alternative;
- primary touch target: at least 44 by 44 CSS pixels;
- text reflow remains usable at 400% zoom for applicable WCAG requirements;
- navigation, tables, charts, filters, dialogs, errors, and status states have defined mobile behavior; and
- portrait and landscape validation is required for representative phone and tablet sizes.

## 4. Accessibility

- target conformance: WCAG 2.2 Level AA;
- automated accessibility scans: zero Critical or Serious violations on required templates;
- keyboard validation: 100% of interactive functions operable without a pointer;
- visible focus, logical focus order, semantic landmarks, names, roles, states, and error association are mandatory;
- contrast meets WCAG AA for text and non-text interface elements;
- 200% text resize and applicable 400% reflow checks pass without loss of content or function;
- charts and status indicators provide non-color meaning and an accessible textual or tabular alternative; and
- manual review includes screen-reader smoke tests for navigation and critical journeys.

Automated tools alone cannot establish accessibility PASS.

## 5. Security

- no unresolved Critical or High vulnerability is permitted for an MVP release;
- WordPress core, runtime, plugins, themes, and third-party dependencies shall be supported and security-maintained;
- privileged operations require server-side authorization and request-integrity protection;
- input validation, output encoding, prepared data access, least privilege, secure headers, and safe error handling apply at trust boundaries;
- secrets, credentials, personal data, and plant-sensitive data are prohibited from source, logs, fixtures, and public content;
- dependency and secret scanning is required before merge where implementation is present;
- security review covers OWASP Top 10 and applicable WordPress risks before production; and
- Critical security findings block merge or Release; High findings require correction or explicit time-bounded owner acceptance before Release.

Authentication implementation, identity-provider selection, and role matrices remain separately approved work.

## 6. Observability

- 100% of unhandled server errors produce a timestamped, severity-classified event with a correlation identifier;
- critical requests propagate a correlation identifier across Platform-owned boundaries;
- logs distinguish operational state, validation failure, security event, dependency failure, and user-correctable error;
- logs and telemetry contain no secrets or sensitive payloads by default;
- health evidence distinguishes core Platform, WordPress, persistence, cache, and future integration dependencies;
- performance measurements cover server latency, error rate, and critical client experience; and
- every alert proposal identifies owner, condition, consequence, response expectation, and false-positive review.

No monitoring vendor, log platform, dashboard, or alert implementation is selected by this baseline.

## 7. Browser and Device Support

### Required browsers

- current and previous major releases of Chrome and Edge;
- current and previous major release of Firefox;
- current and previous major release of Safari on macOS;
- current and previous major release of Mobile Safari on supported iOS;
- current and previous major release of Chrome on supported Android.

### Device classes

- representative 320–430 CSS pixel phones;
- representative 768–1024 CSS pixel tablets;
- representative 1280–1920 CSS pixel desktop and laptop displays; and
- keyboard-only and screen-reader configurations.

Progressive enhancement may provide reduced non-critical presentation in older or constrained environments, but critical information and navigation shall remain available. Exact operating-system versions shall be recorded in each Release support matrix.

## 8. Recovery Expectations

| Recovery measure | Baseline target |
|---|---:|
| Recovery Time Objective for production web MVP | ≤ 4 hours |
| Recovery Point Objective for governed application data | ≤ 24 hours until a stricter data-class requirement is approved |
| Configuration reconstruction | Reproducible from approved Repository state and protected environment records |
| Rollback decision | Defined before every material production Release |
| Backup restoration validation | At least before first production Release and after material backup or migration change |

Future SCADA observations, alarms, financial records, or regulated data may require stricter RTO/RPO and retention rules. Those requirements shall be approved before such data enters production scope.

Recovery evidence shall identify version, backup or source, executor, environment, elapsed time, data loss, validation, anomalies, and disposition.

## 9. Quality Gate Application

Before Dashboard implementation is authorized, Platform Architecture v1.0 shall map each baseline target to:

- an accountable owner;
- an architecture mechanism or constraint;
- a validation method and environment;
- a QA artifact;
- a Release gate or approved exception path; and
- a revalidation trigger.

## 10. Explicit Non-decisions

This proposal does not select hosting, CDN, cache, observability vendor, security product, CI tool, browser-testing service, backup system, deployment environment, authentication provider, database, schema, API, or implementation library.

It does not claim current compliance because no Dashboard or Platform implementation has been authorized.

## Risks and Open Questions

| Item | Required disposition before implementation or Release |
|---|---|
| Hosting and geography unknown | Validate latency and availability targets against the approved environment |
| Expected user concurrency unknown | Establish workload assumptions and load-test model before production |
| Plant network conditions unknown | Validate field network profiles before operational features |
| Data criticality not classified | Approve stricter RPO/RTO for affected future domains |
| Browser analytics unavailable | Use the baseline matrix until governed evidence supports change |
| Accessibility test tooling unselected | Select tools and manual methods in the QA plan, not architecture authority |

## Acceptance Criteria

- every requested non-functional area has measurable targets or an explicit evidence rule;
- targets distinguish proposal from observed compliance;
- security, accessibility, and truthful degraded states contain non-negotiable gates;
- browser and device support is bounded and testable;
- recovery expectations define initial RTO and RPO;
- no vendor or implementation is selected; and
- CTO approval occurs before Dashboard implementation.
