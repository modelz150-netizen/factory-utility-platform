# UtilityAI Integration Contract

| Field | Value |
|---|---|
| Status | Draft for review |
| Version | 0.1.0 |
| Effective date | 2026-08-16 |
| Platform repository | `modelz150-netizen/factory-utility-platform` |
| AI engine repository | `modelz150-netizen/UtilityAI` |
| Current validated UtilityAI baseline | V7.2 external Snapshot + Trend input |

## 1. Purpose

This contract defines the integration boundary between Factory Utility Platform and the independent UtilityAI diagnostic engine. It prevents duplicate implementation, prevents direct provider coupling, and preserves the platform architecture rule that operational and external data enter only through validated adapters.

UtilityAI remains an independent diagnostic service/codebase. Factory Utility Platform consumes only an explicit, versioned interface and does not copy UtilityAI engine code into this repository.

## 2. Responsibility Boundary

### Factory Utility Platform owns

- Product UX and dashboards
- User access and application workflow
- Integration orchestration
- Presentation of advisory AI results
- Audit/display metadata required by the platform
- Approval workflow when human acknowledgement is required
- Governance, architecture, QA, and release evidence

### UtilityAI owns

- SCADA snapshot normalization
- Trend loading and data-quality validation
- Rule Engine
- Trend analysis
- Fact Priority and evidence-conflict handling
- Historical RCA/RAG retrieval
- Gemma/AI inference
- AI output validation and self-correction
- Diagnostic action generation
- Safety flags for advisory-only behavior

## 3. Integration Flow

```text
PCVue / approved SCADA export
        |
        v
Validated Integration Adapter
        |
        +--> Snapshot JSON
        +--> Trend CSV/JSON
        |
        v
UtilityAI
  Data Quality Gate
  -> Trend Analysis
  -> Rule Engine
  -> Fact Priority
  -> Historical RCA/RAG
  -> AI Analysis
  -> Validator/Self-Correction
  -> Diagnostic Action Engine
  -> Safety Gate
        |
        v
Advisory Result
        |
        v
Factory Utility Platform UI / workflow
```

## 4. Input Contract

### 4.1 Snapshot input

Current V7.2 reference input is a JSON object containing metadata and a `tags` object.

```json
{
  "timestamp": "2026-08-16T15:00:00+07:00",
  "system": "CDA",
  "equipment_group": "CDA_B",
  "tags": {
    "CDA_HEADER_PRESSURE": "4.0",
    "DRYER_INLET_PRESSURE": "6.1",
    "DRYER_OUTLET_PRESSURE": "4.2",
    "DRYER_DP": "1.9",
    "FINAL_FILTER_DP": "0.2",
    "COMPRESSOR_AVERAGE_LOAD": "92"
  }
}
```

Source tag names are not platform-domain names. UtilityAI must normalize them through a controlled tag map before analysis.

### 4.2 Trend input

Current V7.2 reference Trend input is CSV or JSON and must contain, at minimum:

- `timestamp`
- `cda_header_pressure_bar`
- `dryer_dp_bar`
- `final_filter_dp_bar`
- `compressor_average_load_pct`

Trend data must pass the UtilityAI Data Quality Gate before diagnostic analysis proceeds.

### 4.3 Future alarm input

Alarm/event input is not yet part of this baseline contract. A future version must define alarm identity, timestamp, state, acknowledgement, equipment association, severity, and related tags before production use.

## 5. Evidence Priority Contract

UtilityAI shall preserve this evidence precedence:

```text
REALTIME_SCADA_FACT
> SCADA_TREND
> RULE_ENGINE
> HISTORICAL_RCA_RAG
> AI_INFERENCE
```

Historical RCA is supporting evidence only. It must never override conflicting current measured facts.

## 6. Output Contract

The platform should treat UtilityAI output as a structured advisory result. The baseline response should expose or allow derivation of:

- data-quality status
- analysis accepted/rejected status
- current facts
- trend suspect zone
- fact-priority primary zone
- evidence conflicts
- weakened/excluded hypotheses
- AI hypotheses
- required verification checks
- recommended diagnostic actions
- operation decision text
- `automatic_control_allowed`
- `operator_approval_required`

A future API contract should stabilize these fields into a versioned JSON schema before runtime service integration.

## 7. Safety Contract

The current integration is advisory only.

Mandatory baseline rules:

- `automatic_control_allowed` must remain `false`.
- `operator_approval_required` must remain `true` for operational action recommendations.
- Factory Utility Platform must not convert advisory output directly into PLC/SCADA control commands.
- No automatic bypass, start/stop, valve operation, setpoint change, or interlock override is authorized by this contract.
- Any future control authority requires a separate architecture decision, safety review, cyber-security review, operational approval workflow, test evidence, and explicit production authorization.

## 8. Data and Security Boundary

- Production OT data must not be committed to either repository.
- Credentials, endpoints, passwords, private keys, and sensitive plant identifiers must not be embedded in source code or public fixtures.
- Repository fixtures must be simulated, sanitized, or explicitly approved non-production samples.
- Live PCVue/SCADA connectivity requires a separately approved adapter and deployment design.
- Logs must avoid exposing sensitive operational data unless the approved deployment design permits it.

## 9. Repository Rule

There shall be no duplicate source of truth.

- UtilityAI executable diagnostic engine code lives in `UtilityAI`.
- Factory Utility Platform stores only platform-side adapters, orchestration, schemas/contracts, UI consumption logic, governance, QA, and release evidence.
- Changes to a durable cross-repository interface require an ADR or equivalent approved architecture decision in Factory Utility Platform.

## 10. Current Validation Baseline

The current UtilityAI V7.2 baseline has been locally validated with external Snapshot JSON and Trend CSV inputs. Expected safety/diagnostic outcome for the approved CDA test fixture is:

```text
Automatic Control Allowed: False
Operator Approval Required: True
FINAL RESULT: ANALYSIS ACCEPTED
SCADA DATA QUALITY: PASS
TREND SUSPECT ZONE: DRYER
FACT PRIMARY ZONE: DRYER
```

This is non-production validation evidence only and does not authorize live operational integration.

## 11. Next Contract Revisions

The next revisions should define:

1. actual sanitized PCVue export adapter schema
2. alarm/event schema
3. versioned UtilityAI result JSON schema
4. error/timeout/fallback behavior
5. audit and trace identifiers
6. service invocation method for the closed-network deployment
7. platform-side acceptance and presentation rules

## 12. Production Gate

Production integration remains prohibited until all of the following are approved:

- sanitized real PCVue format characterization
- adapter validation
- data-quality acceptance criteria
- versioned input/output schemas
- closed-network deployment architecture
- cyber-security review
- failure-mode and recovery tests
- operator workflow validation
- QA evidence
- explicit production authorization under Factory Utility Platform governance
