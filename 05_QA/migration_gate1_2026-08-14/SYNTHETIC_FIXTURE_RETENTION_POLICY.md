# Synthetic Fixture Retention Policy

| Field | Value |
|---|---|
| Status | Final proposal |
| Evaluated fixture candidates | 176 |
| SYNTHETIC_SAFE_FOR_GIT=YES | 91 files / 1,171,928 bytes |
| SYNTHETIC_SAFE_FOR_GIT=NO | 85 files / 510,160 bytes |

A fixture may be tracked only when all conditions hold:

1. Artificially generated and traceable to a test scenario.
2. No real credential, token, key, certificate or secret value.
3. No real OT endpoint, IP, hostname, Production path or Production tag value.
4. Minimal size needed to reproduce one behavior.
5. Clearly located under an approved synthetic fixture path.
6. No copied Production row or binary native project.
7. Stable expected result and owning test documented.

Negative security fixtures containing credential-like sentinels are not retained as static files. Future tests should generate them at runtime from non-secret fragments and remove them after the run. Duplicated execution roots such as Project Files copies are generated output, not canonical fixtures.

The per-file YES/NO result is recorded in MANUAL_REVIEW_FINAL_CLASSIFICATION.csv. YES does not stage a file; it only makes the file eligible for later human-reviewed Git inclusion.
