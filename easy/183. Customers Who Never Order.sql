-- Problem: Customers who did not place any orders
-- Category: Join Operations / Customer Analysis
-- Insight: Identifies customers(names) with no purchase history, useful for churn analysis and targeted marketing campaigns.

SELECT c.name AS Customers
FROM Customers c 
LEFT JOIN Orders o ON c.id = o.customerId
WHERE o.customerId IS NULL;
