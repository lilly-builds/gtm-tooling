---
title: ClickHouse GTM knowledge
source_path: /Users/love/agent-guides/clickhouse-plg-guide.md
handoff_source: /Users/love/agent-guides/clickhouse-rudderstack-handoff.md
official_docs: https://clickhouse.com/docs/
---

# ClickHouse mental model

ClickHouse is the analytical warehouse in this local PLG spine. It is optimized for scans, time-based analysis, segmentation, and account scoring—not the product database's transactional first-success decision.

## Durable boundaries

Keep raw evidence append-only. Preserve stable IDs, `occurred_at`, and `received_at`. `ORDER BY` helps query speed but is not a uniqueness constraint. A deduplication model must be explicit and testable.

## RudderStack destination

Use a dedicated loader user, secure port 9440, the correct service hostname without a protocol prefix, and explicit secure settings. Separate Cloud-management credentials from SQL credentials. The warehouse destination landing must be proven by a query after the sync interval.

## GTM output

Canonical account tables should have one row per organization. An activation mart adds score, qualification status, reason, and truth status for routing. ClickHouse stands in for BigQuery in this sandbox; the Expo interview mapping is the same warehouse role with different SQL and operations.
