-- Problem:  to get the names of products that have at least 100 units ordered in February 2020 and their amount.
SELECT 
    p.product_name,
    SUM(o.unit) AS unit
FROM Products p
JOIN Orders o
ON p.product_id = o.product_id
WHERE o.order_date >= '2020-02-01' AND o.order_date <= '2020-02-29'
GROUP BY p.product_id
HAVING unit >= 100