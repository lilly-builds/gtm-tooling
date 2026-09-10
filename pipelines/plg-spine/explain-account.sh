#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
org_id="${1:?Usage: ./explain-account.sh <org_id>}"
: "${CLICKHOUSE_HOST:?Set CLICKHOUSE_HOST in .env.local}"
: "${CLICKHOUSE_RUDDERSTACK_LOADER_PASSWORD:?Set CLICKHOUSE_RUDDERSTACK_LOADER_PASSWORD in .env.local}"
clickhouse client --secure --host "$CLICKHOUSE_HOST" --port "${CLICKHOUSE_PORT:-9440}" \
  --user rudderstack_loader --password "$CLICKHOUSE_RUDDERSTACK_LOADER_PASSWORD" \
  --database eas_plg --query "SELECT org_id, user_id, project_id, pqa_score, is_pqa, truth_status FROM pqa_accounts WHERE org_id = {org:String} FORMAT PrettyCompact" \
  --param_org "$org_id"
