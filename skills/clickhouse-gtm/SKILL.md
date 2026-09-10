---
name: clickhouse-gtm
description: Use when inspecting or operating ClickHouse as the PLG analytics warehouse.
uses: [tools/clickhouse, knowledge/clickhouse-gtm]
auth_prerequisite: A dedicated database user for SQL; Cloud-management API credentials only for Cloud service changes.
entry: The ClickHouse service, database, and intended query or schema change are known.
exit: A bounded query or schema action completes with evidence and no secrets exposed.
guard: Keep Cloud-management auth separate from database auth; use the dedicated loader for pipeline setup and read-only access for analysis.
bound: Stop before resize, delete, broad network changes, or unknown permissions; ask a human.
---

# ClickHouse GTM skill

1. Use `chctl` for Cloud service inspection and `clickhouse client` for SQL.
2. Confirm the active credential source and server-side access before Cloud mutations.
3. Query only needed columns with bounded time windows.
4. Preserve raw evidence; model canonical account tables separately.
5. Keep `occurred_at` and `received_at` to measure late delivery.
6. Verify organization-level output before any activation claim.
