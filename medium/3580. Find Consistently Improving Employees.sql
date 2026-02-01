-- Problem: to find employees who have consistently improved their performance over their last three reviews.

-- An employee must have at least 3 review to be considered
-- The employee's last 3 reviews must show strictly increasing ratings (each review better than the previous)
-- Use the most recent 3 reviews based on review_date for each employee
-- Calculate the improvement score as the difference between the latest rating and the earliest rating among the last 3 reviews
WITH RankedReviews AS (
    SELECT
        pr.employee_id,
        pr.review_date,
        pr.rating,
        ROW_NUMBER() OVER (
            PARTITION BY pr.employee_id
            ORDER BY pr.review_date DESC
        ) AS rn
    FROM performance_reviews pr
),

LastThree AS (
    SELECT *
    FROM RankedReviews
    WHERE rn <= 3
),

CheckTrend AS (
    SELECT
        employee_id,
        MAX(CASE WHEN rn = 1 THEN rating END) AS r1, -- most recent
        MAX(CASE WHEN rn = 2 THEN rating END) AS r2,
        MAX(CASE WHEN rn = 3 THEN rating END) AS r3  -- oldest of last 3
    FROM LastThree
    GROUP BY employee_id
    HAVING COUNT(*) = 3  -- must have at least 3 reviews
       AND r3 < r2
       AND r2 < r1       -- strictly increasing
)

SELECT
    e.employee_id,
    e.name,
    (c.r1 - c.r3) AS improvement_score
FROM CheckTrend c
JOIN employees e
    ON e.employee_id = c.employee_id
ORDER BY improvement_score DESC, e.name ASC;
