-- Problem: to find loyal customers. A customer is considered loyal if they meet ALL the following criteria:

-- Made at least 3 purchase transactions.
-- Have been active for at least 30 days.
-- Their refund rate is less than 20% .
WITH details_table AS
    (SELECT
        customer_id,
        SUM(CASE WHEN transaction_type = 'purchase' THEN 1 ELSE 0 END) AS purchase_count,
        SUM(CASE WHEN transaction_type = 'refund' THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS refund_rate,
        CASE 
            WHEN DATEDIFF(MAX(transaction_date), MIN(transaction_date)) >= 30 
            THEN TRUE 
            ELSE FALSE 
        END AS active_for_30days
    FROM customer_transactions
    GROUP BY customer_id)

SELECT
    customer_id
FROM details_table
WHERE purchase_count >= 3
AND refund_rate < 0.2
AND active_for_30days IS TRUE
