-- Problem: Finding the average selling price for each product
-- Category: Left Join, Aggregation
-- Insight: Helps businesses understand the average price customers pay per product, supporting pricing strategy and revenue analysis.
SELECT 
    p.product_id,
    ROUND(
        IFNULL(SUM(p.price * u.units) / SUM(u.units), 0),
        2
    ) AS average_price
FROM Prices p
LEFT JOIN UnitsSold u
ON p.product_id = u.product_id
AND u.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY p.product_id;


