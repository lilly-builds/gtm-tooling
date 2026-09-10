---
name: dbt-gtm
description: Use when shaping, testing, and scoring warehouse data for GTM decisions.
uses: [tools/dbt, knowledge/dbt-brain]
auth_prerequisite: A dbt profile that points to the intended warehouse and uses environment-backed credentials.
entry: Source tables and the business decision grain are known.
exit: Parse, run, and test succeed; model grain and truth limitations are documented.
guard: Do not mix grains or silently deduplicate source evidence; use `ref` and `source` dependencies.
bound: Stop on connection, schema, or test failure; do not weaken tests to make a run green.
---

# dbt GTM skill

1. State the business question and one-row grain.
2. Separate staging cleanup, quality flags, canonical business grain, and activation marts.
3. Use `dbt debug`, `dbt parse`, `dbt run`, then `dbt test`.
4. Keep duplicate and incomplete rows visible in quality models.
5. Use typed fields for IDs, scores, statuses, timestamps, and routing decisions.
6. State what the warehouse proves and what only product systems can prove.
