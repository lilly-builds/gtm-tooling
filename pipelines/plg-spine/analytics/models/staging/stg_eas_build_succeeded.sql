-- Clean, typed event layer over RudderStack's ClickHouse table.
SELECT
    id AS event_id,
    nullIf(org_id, '') AS org_id,
    nullIf(project_id, '') AS project_id,
    nullIf(user_id, '') AS user_id,
    platform,
    toUInt8(ifNull(is_first_success, 0)) AS is_first_success,
    coalesce(timestamp, original_timestamp, received_at) AS occurred_at,
    received_at,
    dateDiff('second', coalesce(timestamp, original_timestamp, received_at), received_at) AS delivery_delay_seconds,
    event,
    event_text,
    context_source_id,
    context_destination_id
FROM {{ source('rudderstack', 'eas_build_succeeded') }}
WHERE event = 'eas_build_succeeded'
   OR event_text = 'EAS Build Succeeded'
