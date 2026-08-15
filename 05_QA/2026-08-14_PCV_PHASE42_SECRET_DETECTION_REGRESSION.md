# Phase 4.2 Secret Detection Regression

| Fixture | Expected | Observed | Result |
|---|---|---|---|
| VERSION local Windows path | accepted as discarded metadata | VAREXP_01/03/04 schema discovery PASS | PASS |
| Credential/token in VERSION | fail closed without raw value | SENSITIVE_VERSION_METADATA | PASS |
| Credential/token in data | fail closed without raw value | SENSITIVE_DATA_CREDENTIAL | PASS |
| Standalone key in VERSION | fail closed without raw value | SENSITIVE_VERSION_METADATA | PASS |
| Schema-first VAREXP | schema accepted | record 1 verified | PASS |
| VERSION + schema | preamble discarded, schema accepted | record 2 verified | PASS |
| Secret sentinel leakage | 0 | 0 | PASS |

Password, passwd, pwd, credential, secret, token, private/API key and certificate detection remains fail-closed. Only a backslash by itself in a structurally valid discarded VERSION local-path field is contextually exempt.
