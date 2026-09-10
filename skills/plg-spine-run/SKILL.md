---
name: plg-spine-run
description: Use when proving the complete local product-signal-to-account-score path.
uses: [skills/rudderstack-plg, skills/clickhouse-gtm, skills/dbt-gtm, pipelines/plg-spine]
auth_prerequisite: Existing RudderStack source/destination and local environment values; no secrets in Git.
entry: Pipeline configuration already exists and a test org/project/user are approved.
exit: One event is sent, warehouse landing is observed, dbt models/tests pass, and organization output is shown.
guard: Verify each boundary separately; never treat an HTTP 200 as warehouse proof.
bound: One bounded test run; stop before CRM writes or service changes without explicit approval.
---

# PLG spine run skill

Run the commands in the pipeline README. Verify in this order:

1. Product sender emits identify and track.
2. RudderStack accepts and displays the source event.
3. ClickHouse contains the landed row.
4. dbt builds staging, quality, canonical, and PQA models.
5. The account output explains its score and truth status.

The current MVP is a demo path, not production first-success logic.
