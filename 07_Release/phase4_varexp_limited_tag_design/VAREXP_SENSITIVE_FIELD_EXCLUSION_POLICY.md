# VAREXP Sensitive Field Exclusion Policy

## Principle

Initial Utility AI value acquisition must exclude fields likely to reveal network topology, endpoints, addressing, communication configuration, control expressions, station associations, or source-system mappings. Utility value does not override OT sensitivity.

## Excluded categories

- Generic Source and station/association identifiers.
- Equipment network, equipment, frame, index, size, and encoding mappings.
- Server/client list names and DDE mappings.
- OPC server, group, item ID, access path, array, and customization fields.
- BACnet network/device/object/property and EDE mappings.
- IEC 60870-5-104 network/device/sector/IOA/write/control/time-tag mappings.
- IEC 61850 network/device/data-group/member/control-model fields.
- SNMP network/device/scan group/OID and extraction fields.
- OPC UA network/client/monitoring/identifier/namespace fields.
- Alarm mask expressions and other executable or control-expression-like metadata.

The exact positional exclusions are recorded in VAREXP_DATA_ACQUISITION_COLUMN_CLASSIFICATION.csv as EXCLUDED_SENSITIVE.

## Runtime handling for a future Pilot

- Excluded values may be tokenized only in memory to maintain 262-field positional alignment.
- They must not be stored, logged, hashed individually, sampled, previewed, encoded, or included in error messages.
- Detect credential/secret patterns across the logical record before output emission.
- On password, credential, secret, token, private-key, API-key, or connection-string patterns, stop that file and return SENSITIVE_REVIEW_REQUIRED without the matched value.
- Do not attempt value masking as a substitute for exclusion.

## OT metadata

Tagname and Description are themselves OT-sensitive. They are allowed only because they are essential to the proposed limited Pilot. The future result package must be access-controlled and marked OT-SENSITIVE / FIELD_USE_NOT_APPROVED.

## Prohibited expansion

No allowlist expansion to communication/address fields, QUALIFIER_VARIANT fields, empty positions, HISTO, DAT, XLSX, XML, PLC, OPC, DB, or network sources is authorized by this policy.
