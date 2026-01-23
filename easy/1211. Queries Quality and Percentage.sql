-- Problem: to find each query_name, the quality and poor_query_percentage.
-- Category: Aggregation, Group By
-- Insight: identifies which search queries perform poorly so they can optimize results and improve user experience.
SELECT
    query_name,
    ROUND(AVG(rating / position), 2) AS quality,
    ROUND(
        SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS poor_query_percentage
FROM Queries
GROUP BY query_name;
