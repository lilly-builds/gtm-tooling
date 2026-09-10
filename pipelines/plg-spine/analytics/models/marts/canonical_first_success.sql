-- One deterministic representative per organization.
-- IMPORTANT: this selects one row from events that claim is_first_success=1;
-- it cannot prove first-ever success without durable product build history.
SELECT *
FROM (
    SELECT
        q.*,
        row_number() OVER (
            PARTITION BY org_id
            ORDER BY occurred_at ASC, received_at ASC, event_id ASC
        ) AS org_first_success_rank
    FROM {{ ref('dq_eas_build_succeeded') }} AS q
    WHERE q.org_id IS NOT NULL
      AND q.is_first_success = 1
)
WHERE org_first_success_rank = 1
