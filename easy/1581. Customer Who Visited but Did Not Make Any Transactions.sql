-- Problem: to find the IDs of the users who visited without making any transactions and the number of times they made these types of visits.

SELECT
    customer_id,
    SUM(CASE WHEN v.visit_id IS NOT NULL AND t.transaction_id IS NULL 
    THEN 1 ELSE 0 END) AS count_no_trans
FROM 
    Visits v
LEFT JOIN 
    Transactions t
ON v.visit_id = t.visit_id
GROUP BY customer_id
HAVING count_no_trans <> 0