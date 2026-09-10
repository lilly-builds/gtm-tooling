# Agent retrieval contract

This repository is a small file-based retrieval graph for the go-to-market (GTM) tooling spine.

1. Start at `GRAPH.md` or the matching folder under `skills/`.
2. Load only that skill and its declared `uses` neighbors (one tool and one knowledge node when possible).
3. Do not read every platform guide by default.
4. Treat every `SKILL.md` as a process contract: entry, exit, guard, and bound are mandatory.
5. Keep secrets in local environment files or secret managers, never in Git.
6. The data-flow graph is RudderStack → ClickHouse → dbt → activation. It is not an agent-memory database.
