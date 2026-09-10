#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
: "${WRITE_KEY:?Set WRITE_KEY in .env.local}"
: "${DATA_PLANE_URL:?Set DATA_PLANE_URL in .env.local}"
: "${CLICKHOUSE_HOST:?Set CLICKHOUSE_HOST in .env.local}"
: "${CLICKHOUSE_RUDDERSTACK_LOADER_PASSWORD:?Set CLICKHOUSE_RUDDERSTACK_LOADER_PASSWORD in .env.local}"
npm run send:eas-build-succeeded
.venv/bin/dbt run --project-dir analytics --profiles-dir analytics --threads 1
.venv/bin/dbt test --project-dir analytics --profiles-dir analytics --threads 1
