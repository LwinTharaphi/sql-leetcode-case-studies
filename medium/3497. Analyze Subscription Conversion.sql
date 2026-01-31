-- Problem: Find users who converted from free trial to paid subscription
-- Calculate each user's average daily activity duration during their free trial period (rounded to 2 decimal places)
-- Calculate each user's average daily activity duration during their paid subscription period (rounded to 2 decimal places)

SELECT 
    user_id,
    ROUND(AVG(CASE WHEN activity_type = 'free_trial' THEN activity_duration END), 2) AS trial_avg_duration,
    ROUND(AVG(CASE WHEN activity_type = 'paid' THEN activity_duration END), 2) AS paid_avg_duration
FROM UserActivity
GROUP BY user_id
HAVING trial_avg_duration IS NOT NULL AND paid_avg_duration IS NOT NULL