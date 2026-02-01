--  Problem: to find the most popular product category for each season. The seasons are defined as:

-- Winter: December, January, February
-- Spring: March, April, May
-- Summer: June, July, August
-- Fall: September, October, November
-- The popularity of a category is determined by the total quantity sold in that season. If there is a tie, select the category with the highest total revenue (quantity × price). If there is still a tie, return the lexicographically smaller category.

WITH season_sales AS(SELECT
    CASE
    WHEN MONTH(s.sale_date) IN (12, 1, 2) THEN 'Winter'
    WHEN MONTH(s.sale_date) IN (3, 4, 5) THEN 'Spring'
    WHEN MONTH(s.sale_date) IN (6, 7, 8) THEN 'Summer'
    WHEN MONTH(s.sale_date) IN (9, 10, 11) THEN 'Fall'
END AS season,
    p.category,
    SUM(s.quantity) AS total_quantity,
    SUM(s.price * s.quantity) AS total_revenue
FROM sales s
JOIN products p
ON s.product_id = p.product_id
GROUP BY season, p.category
ORDER BY season, total_quantity DESC) 

SELECT season, category, total_quantity, total_revenue
FROM (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY season
               ORDER BY 
                   total_quantity DESC,     
                   total_revenue DESC,      
                   category ASC            
           ) AS rn
    FROM season_sales
) ranked
WHERE rn = 1



