# gtm-tooling

A small, private operating kit for a Go-To-Market (GTM) engineering agent. It keeps platform procedures, focused knowledge, and the working Product-Led Growth (PLG) spine together without becoming a giant wiki.

## Spine

```text
identify/track from product
  → RudderStack (customer data platform)
  → ClickHouse (warehouse)
  → dbt (data build tool) models and tests
  → product-qualified-account score
  → future HubSpot activation
```

For an Expo-style system, ClickHouse stands in for the warehouse role often filled by BigQuery, and HubSpot is the future activation destination. The local MVP proves ingestion, warehouse landing, modeling, and scoring; HubSpot is intentionally only a stub.

## Retrieval rule

Start at `GRAPH.md` or the matching `skills/<name>/SKILL.md`. Load that skill and only its declared neighbors. Do not load every guide “just in case.” The root graph is a file index, not a persistent memory system.

## Run the working MVP

From `pipelines/plg-spine/`:

```bash
cp .env.example .env.local
# Fill secrets locally; never commit .env.local.
npm install
npm run send:eas-build-succeeded
source .venv/bin/activate  # or use an existing dbt environment
set -a; source .env.local; set +a
dbt debug --project-dir analytics --profiles-dir analytics
dbt run --project-dir analytics --profiles-dir analytics --threads 1
dbt test --project-dir analytics --profiles-dir analytics --threads 1
```

The sender requires an existing RudderStack Node source and ClickHouse destination. The test signal trusts `isFirstSuccess`; product code must eventually decide first-ever eligibility from durable build history and stable build IDs.

## Source provenance

Each knowledge unit keeps its upstream `source_path` in frontmatter. Vendor behavior remains subject to the official documentation linked in the tool cards.
