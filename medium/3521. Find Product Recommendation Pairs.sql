-- Problem: to implement the Customers who bought this also bought... feature based on co-purchase patterns. Write a solution to :

-- Identify distinct product pairs frequently purchased together by the same customers (where product1_id < product2_id)
-- For each product pair, determine how many customers purchased both products
-- A product pair is considered for recommendation if at least 3 different customers have purchased both products.

WITH ProductPairs AS (
    SELECT 
        p1.product_id AS product1_id,
        p2.product_id AS product2_id,
        COUNT(DISTINCT p1.user_id) AS customer_count
    FROM ProductPurchases p1
    JOIN ProductPurchases p2
        ON p1.user_id = p2.user_id
       AND p1.product_id < p2.product_id
    GROUP BY p1.product_id, p2.product_id
    HAVING customer_count >= 3
)

SELECT
    pp.product1_id,
    pp.product2_id,
    pi1.category AS product1_category,
    pi2.category AS product2_category,
    pp.customer_count
FROM ProductPairs pp
JOIN ProductInfo pi1 
    ON pp.product1_id = pi1.product_id
JOIN ProductInfo pi2 
    ON pp.product2_id = pi2.product_id
ORDER BY 
    pp.customer_count DESC,
    pp.product1_id ASC,
    pp.product2_id ASC;
