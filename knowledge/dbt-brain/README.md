---
title: dbt GTM knowledge
source_path: /Users/love/agent-guides/dbt-gtm-guide.md
additional_source_path: /Users/love/Developer/dbt-brain/DBT-BRAIN.md
official_docs: https://docs.getdbt.com/
---

# dbt mental model

dbt (data build tool) compiles and runs SQL models in dependency order. It does not extract or load data. The source system and warehouse landing happen before dbt.

## Model design

Choose the business question first, then define the grain: what one row means. A common PLG path is:

```text
source → staging event grain → quality event grain → canonical organization grain → activation mart
```

Staging does light cleanup. Quality models retain bad rows and add flags. Canonical models establish one business grain. Activation marts are shaped for an operational consumer such as HubSpot.

Use `source()` for landed tables and `ref()` for dbt models. Keep tests next to the contract. Use typed columns for IDs, scores, statuses, and timestamps; reserve JSON/Map for flexible metadata.

## Truth boundary

dbt can expose duplicate, missing, and late data. It cannot prove first-ever product behavior when the event only carries `isFirstSuccess: true`; durable product history and idempotent producer logic are required.
