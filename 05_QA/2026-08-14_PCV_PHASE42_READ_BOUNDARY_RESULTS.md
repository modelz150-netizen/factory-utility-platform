# Phase 4.2 Read Boundary Results

| Boundary | Result |
|---|---|
| Production config records/file | exactly 20 maximum |
| 21-record fixture | 20 read/emitted; 21st not read |
| Bytes/file | stopped exactly at 262,144 bytes |
| Global 101-row QA configuration | exactly 100 emitted; final source stopped at 19 |
| Approved sources | exactly VAREXP_01–05 |
| Source changes | 0; pre/post SHA-256 identical |
| Boundary violations | 0 |

The QA-only global test used a separate test configuration to make a 101st eligible record reachable. The release launcher remains fixed to the immutable Production configuration and exposes no QA configuration override.
