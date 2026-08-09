# Home Dashboard Fixture Scenario Catalogue

| Field | Value |
|---|---|
| Status | Review |
| Version | 0.1.0 |
| Backlog | `DASH-003` |

All scenarios are deterministic, fictional, and visibly `SIMULATED`. Names describe test intent, not a real factory condition.

| Scenario | Required coverage |
|---|---|
| `manager_attention_default` | Critical Electrical condition, warning CDA, degraded redundancy, latest major event and age, prioritized attention, eight Utilities, four P0 KPIs, subordinate P1 context, simulated maintenance |
| `all_normal` | Eight supplied normal states, zero authoritative abnormal counts, no attention items, fresh complete data |
| `critical_dominance` | At least one Critical contributor among otherwise Normal contributors; aggregate must remain Critical |
| `multiple_abnormalities` | Critical and Warning conditions across multiple Utilities with stable management ordering |
| `unknown_input` | Unknown Utility input and truthful aggregate/quality consequence |
| `stale_data` | Last-known values retained with explicit age and stale source disclosure |
| `partial_sources` | Some region/source results present and others missing; usable content plus limitations |
| `health_unavailable` | Overall health unavailable while independent widgets remain renderable |
| `alarm_focus` | Critical, Warning, unacknowledged counts, latest event, affected Utility, duration age |
| `attention_order` | Supplied priority differs from alphabetical/severity-label order; UI must preserve supply order |
| `redundancy_degraded` | No invented Critical alarm, but clear reliability and redundancy management impact |
| `p0_degraded` | All four P0 contracts exercise value/state/provenance without target or formula invention |
| `p1_placeholders` | Energy and water shown as subordinate unavailable/not-configured placeholders |
| `maintenance_simulated` | Fictional PM/work summary visibly simulated |
| `maintenance_unavailable` | No authoritative source; unavailable presentation with no zero counts |
| `single_widget_failure` | One widget adapter fails; remaining page and contained error state render |
| `multiple_widget_failure` | Partial page remains truthful and navigable under several isolated failures |
| `malformed_fixture_rejected` | Invalid count, timestamp, key, or missing simulation marker fails contract validation |
| `timezone_boundary` | Source offsets convert to `Asia/Ho_Chi_Minh` while preserving instant/provenance; age is duration-based |
| `locale_expansion` | Korean, Vietnamese, and English long labels, parameters, plurals, Unicode and fallback behavior |
| `narrow_mobile` | Decision sequence and all truth/provenance cues remain usable at 320/375 CSS px |

## Catalogue controls

- Fixed clocks and stable identifiers make screenshots and tests reproducible.
- Values shall be obviously fictional and shall not use real plant, asset, alarm, employee, customer, endpoint, or credential data.
- Scenario selection belongs to the non-production fixture harness and is never exposed as a production data-source switch.
- Deliberate delays and failures are local deterministic test behavior only.
- Every screenshot shall identify its scenario and simulation state.
