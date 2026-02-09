-- Problem: to identify zombie sessions, sessions where users appear active but show abnormal behavior patterns. A session is considered a zombie session if it meets ALL the following criteria:

-- The session duration is more than 30 minutes.
-- Has at least 5 scroll events.
-- The click-to-scroll ratio is less than 0.20 .
-- No purchases were made during the session.

SELECT 
    session_id,
    user_id,
    TIMESTAMPDIFF(
        MINUTE,
        MIN(event_timestamp),
        MAX(event_timestamp)
    ) AS session_duration_minutes,

    SUM(event_type = 'scroll') AS scroll_count

FROM app_events
GROUP BY session_id, user_id
HAVING session_duration_minutes > 30
   AND scroll_count >= 5
   AND SUM(event_type = 'purchase') = 0
   AND (SUM(event_type = 'click') / NULLIF(SUM(event_type = 'scroll'), 0)) < 0.20
ORDER BY scroll_count DESC, session_id ASC;

