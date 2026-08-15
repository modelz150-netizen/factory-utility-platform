# VAREXP Secret Detection Layer Design

| Field | Value |
|---|---|
| Status | Proposed — manual approval required |
| Date | 2026-08-14 |

## Required order

1. Read within the existing schema-discovery boundary.
2. Parse CSV in memory without logging raw records.
3. Classify strict VERSION, 262-column schema, or unknown structure.
4. Apply a record-type-specific detector.
5. Discard non-schema raw buffers.
6. Allow data access only after positional schema/hash validation.

| Layer | Input | Allowed audit output | Decision |
|---|---|---|---|
| L0 record classifier | bounded record | type/count/hash only | unknown fails closed |
| L1 VERSION metadata | typed preamble fields | category flags only | credential-shaped data fails; local drive-path metadata is discarded, while UNC/URL/IP/endpoint remains review-required |
| L2 schema names | exact 262 headers | positional IDs/original headers/hash | descriptive network names are not values; unknown credential semantics require review |
| L3 data values | 262 parsed fields | rule ID and positional ID only on match | retain strict credential, token, key, certificate, URL, endpoint, IP, UNC/device and remote-connection checks |
| L4 output | approved fields | allowlisted values/provenance | re-scan serialized output and fail closed |

## Non-negotiable controls

- Never globally relax credential/secret detection.
- A sensitive-looking header never authorizes its value.
- Schema-name and data-value events are separate.
- A match stores layer, rule, position and decision, never the matched raw value.
- Local path metadata is ignorable only inside a structurally valid discarded VERSION preamble.
- Unexpected preamble structure or remote-path syntax remains review-required.

Design only; no Collector change or Production execution is authorized.
