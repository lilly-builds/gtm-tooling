-- Simple explainable product-qualified-account score for the sandbox.
-- This is an analytics score, not a replacement for product eligibility logic.
SELECT
    org_id,
    user_id,
    project_id,
    occurred_at AS first_success_at,
    event_id AS representative_event_id,
    50 AS first_success_points,
    if(user_id IS NOT NULL, 10, 0) AS identified_user_points,
    if(project_id IS NOT NULL, 10, 0) AS project_points,
    if(is_duplicate_org_build_success, -20, 0) AS duplicate_penalty,
    if(is_duplicate_event_id, -20, 0) AS duplicate_event_penalty,
    50 + if(user_id IS NOT NULL, 10, 0) + if(project_id IS NOT NULL, 10, 0)
      + if(is_duplicate_org_build_success, -20, 0)
      + if(is_duplicate_event_id, -20, 0) AS pqa_score,
    (50 + if(user_id IS NOT NULL, 10, 0) + if(project_id IS NOT NULL, 10, 0)
      + if(is_duplicate_org_build_success, -20, 0)
      + if(is_duplicate_event_id, -20, 0)) >= 70 AS is_pqa,
    'claimed_first_success; durable_first_ever_unverified' AS truth_status
FROM {{ ref('canonical_first_success') }}
