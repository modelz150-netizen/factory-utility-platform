# VAREXP Schema Validation Report

## Scope and evidence boundary

This Gate uses only the schema headers already stored in the RC5 Production result ZIP. Production files and data rows were not read, and RC5 was not rerun. HISTO, DAT, XLSX, XML, PLC, OPC, DB, and Production network sources were not accessed.

Source ZIP SHA-256: 1B100D2C82C372C78F0D55A39951FC6AA9DDB67EE5D22A9354DB59620CE4B3C5.

## Five-file structural comparison

| Criterion | Result |
|---|---|
| Five VAREXP schemas found | PASS |
| 262 columns in every file | PASS |
| 85 empty headers in every file | PASS |
| Empty-column index pattern identical 5/5 | PASS |
| Duplicate headers absent | PASS |
| Malformed CSV absent | PASS |
| Non-empty index/name pattern exactly identical 5/5 | **FAIL** |
| Exact header-name conflict positions | **26** |

The 85 empty positions are identical in all five schemas. They are recorded as ReservedCandidate, not as confirmed reserved or unused fields.

The 26 non-empty conflicts split into:

- 19 capitalization variants, such as ThresholdValue versus Thresholdvalue.
- 7 hierarchy-label variants at columns 3–9: n1 through n7 versus annotated names such as n1(Factory) and n7(In2).

All conflicting positions remain populated in all five files; there is no positional displacement. Nevertheless, the required exact non-empty header index/name identity criterion is not satisfied.

## Empty-column conclusion

The identical 85-position pattern is strong empirical evidence of a stable positional layout. It supports the label ReservedCandidate. It does not prove that PCVue defines these positions as reserved, unused, or semantically ignorable.

## Gate decision

The requested VAREXP_SCHEMA_CONSISTENT_CANDIDATE criteria are not all met because the non-empty header-name pattern is not exactly identical across five files. No official PCVue 16.2 VAREXP field specification confirming the empty positions was located.

**Final VAREXP decision: STRUCTURE_CONFLICT**

This decision is conservative and refers to exact schema-name consistency, not CSV corruption. The five files remain positionally aligned and parse successfully. RC6 and VAREXP data-row collection are not authorized.
