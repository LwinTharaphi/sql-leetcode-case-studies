-- Problem: to identify behaviorally stable users based on the following definition:

-- A user is considered behaviorally stable if there exists a sequence of at least 5 consecutive days such that:
-- The user performed exactly one action per day during that period.
-- The action is the same on all those consecutive days.
-- If a user has multiple qualifying sequences, only consider the sequence with the maximum length.
SELECT
    user_id,
    action,
    COUNT(*) AS streak_length,
    MIN(action_date) AS start_date,
    MAX(action_date) AS end_date
FROM activity
GROUP BY user_id,action
HAVING count(*) >= 5
ORDER BY COUNT(*) DESC
