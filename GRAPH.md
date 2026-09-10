# GTM tooling graph

This is a retrieval map, not a graph database. It contains only the paths an agent needs to operate the PLG (Product-Led Growth) spine.

## Program/retrieval graph

| Node | Type | Use when |
|---|---|---|
| `skills/rudderstack-plg` | skill | instrument or route product events |
| `skills/clickhouse-gtm` | skill | inspect warehouse data or delivery |
| `skills/dbt-gtm` | skill | model, test, or score data |
| `skills/plg-spine-run` | skill | run the complete local proof |
| `tools/rudderstack` | tool | use `rudder-cli` and Control Plane API |
| `tools/clickhouse` | tool | use `chctl` and secure SQL |
| `tools/dbt` | tool | use dbt CLI |
| `knowledge/rudderstack-plg` | knowledge | understand event truth and delivery |
| `knowledge/clickhouse-gtm` | knowledge | understand warehouse and PQA use |
| `knowledge/dbt-brain` | knowledge | choose grains, models, and tests |
| `pipelines/plg-spine` | pipeline | exercise the working MVP |

## Data-flow graph

```text
Product identify/track
  --emits_to--> RudderStack
  --emits_to--> ClickHouse raw tables
  --modeled_by--> dbt staging/quality/canonical models
  --activates--> PQA score and future CRM routing
```

## Retrieval edges

- `skills/rudderstack-plg` uses `tools/rudderstack` and `knowledge/rudderstack-plg`.
- `skills/clickhouse-gtm` uses `tools/clickhouse` and `knowledge/clickhouse-gtm`.
- `skills/dbt-gtm` uses `tools/dbt` and `knowledge/dbt-brain`.
- `skills/plg-spine-run` uses all three skills and `pipelines/plg-spine`.
