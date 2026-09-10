---
name: clickhouse-tool
source_path: /Users/love/agent-guides/clickhouse-plg-guide.md
official_docs: https://clickhouse.com/docs/
---

# ClickHouse CLI card

## Auth

- `chctl cloud auth login` is Cloud-management auth.
- Current CLI API env names are `CLICKHOUSE_CLOUD_API_KEY` and `CLICKHOUSE_CLOUD_API_SECRET`.
- Prove server acceptance with `chctl cloud --debug service list --json`; “credentials saved” alone is not proof.
- SQL uses a dedicated database user and password, not a Cloud API key.

## High-leverage commands

```bash
chctl --version
chctl cloud auth status
chctl cloud --debug service list --json
clickhouse client --secure --host "$CLICKHOUSE_HOST" --port 9440 --user "$USER" --password "$PASSWORD" --database eas_plg
```

## Common errors

- `Key is not found`: stale or mismatched Cloud key; stop retrying, remove stale credential cache, create a correctly paired key, and rerun server-side preflight.
- Authentication failure: distinguish Cloud API credentials from database credentials.
- Destination validation failure: ClickHouse RudderStack config needs explicit `skipVerify: false` when secure.
