-- Row-level quality flags. Keep every row: quality models report problems;
-- they must not silently delete duplicate or incomplete evidence.
WITH counted AS (
    SELECT
        s.*,
        count() OVER (PARTITION BY event_id) AS event_id_count,
        count() OVER (PARTITION BY org_id, project_id, is_first_success) AS org_build_success_count
    FROM {{ ref('stg_eas_build_succeeded') }} AS s
)
SELECT
    *,
    event_id_count > 1 AS is_duplicate_event_id,
    org_build_success_count > 1 AS is_duplicate_org_build_success,
    user_id IS NULL AS is_missing_user_id,
    org_id IS NULL AS is_missing_org_id,
    delivery_delay_seconds > 900 AS is_late_delivery,
    (event_id_count > 1 OR org_build_success_count > 1 OR user_id IS NULL OR org_id IS NULL OR delivery_delay_seconds > 900) AS has_quality_issue
FROM counted
