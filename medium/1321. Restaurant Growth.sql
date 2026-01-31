-- Problem: Compute the moving average of how much the customer paid in a seven days window (i.e., current day + 6 days before). average_amount should be rounded to two decimal places.
WITH daily AS (
    SELECT 
        visited_on,
        SUM(amount) AS amount,
        ROW_NUMBER() OVER (ORDER BY visited_on) AS rn
    FROM Customer
    GROUP BY visited_on
)
SELECT
    visited_on,
    amount,
    ROUND(amount / 7, 2) AS average_amount
FROM (
    SELECT
        visited_on,
        SUM(amount) OVER (
            ORDER BY visited_on
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ) AS amount,
        rn
    FROM daily
) t
WHERE rn >= 7
ORDER BY visited_on;
