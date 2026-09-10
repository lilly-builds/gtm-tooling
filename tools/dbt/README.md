---
name: dbt-tool
source_path: /Users/love/agent-guides/dbt-gtm-guide.md
official_docs: https://docs.getdbt.com/
---

# dbt CLI card

## Auth

Use a project-local environment and a profile whose connection values come from environment variables. Do not put passwords in profiles or Git.

## High-leverage commands

```bash
dbt debug --project-dir analytics --profiles-dir analytics
dbt parse --project-dir analytics --profiles-dir analytics
dbt run --project-dir analytics --profiles-dir analytics --threads 1
dbt test --project-dir analytics --profiles-dir analytics --threads 1
dbt ls --project-dir analytics --profiles-dir analytics
```

## Common errors

- No adapter: install the warehouse adapter in the same environment as dbt.
- Model ordering problem: use `source()` and `ref()`, not hardcoded dependency assumptions.
- Green model, wrong business answer: inspect grain, duplicate flags, and source truth boundary.
