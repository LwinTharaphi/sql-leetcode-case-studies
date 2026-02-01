-- Problem: to find employees who are meeting-heavy - employees who spend more than 50% of their working time in meetings during any given week.

-- Assume a standard work week is 40 hours
-- Calculate total meeting hours per employee per week (Monday to Sunday)
-- An employee is meeting-heavy if their weekly meeting hours > 20 hours (50% of 40 hours)
-- Count how many weeks each employee was meeting-heavy
-- Only include employees who were meeting-heavy for at least 2 weeks
WITH weekly_hours AS (
    SELECT
        employee_id,
        YEAR(meeting_date) AS yr,
        WEEK(meeting_date, 1) AS wk,  -- Monday-based weeks
        SUM(duration_hours) AS total_week_hours
    FROM meetings
    GROUP BY employee_id, yr, wk
),
meeting_heavy_weeks AS (
    SELECT
        employee_id,
        COUNT(*) AS meeting_heavy_weeks
    FROM weekly_hours
    WHERE total_week_hours > 20
    GROUP BY employee_id
    HAVING COUNT(*) >= 2
)

SELECT
    e.employee_id,
    e.employee_name,
    e.department,
    m.meeting_heavy_weeks
FROM meeting_heavy_weeks m
JOIN employees e
  ON e.employee_id = m.employee_id
ORDER BY m.meeting_heavy_weeks DESC, e.employee_name ASC;
