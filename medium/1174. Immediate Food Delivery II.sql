-- Problem: to find the percentage of immediate orders in the first orders of all customers, rounded to 2 decimal places.

SELECT
    ROUND
        (100 * SUM(order_date = customer_pref_delivery_date) / COUNT(*),2)
        AS immediate_percentage
FROM Delivery d
JOIN (
    SELECT 
        customer_id, 
        MIN(order_date) AS first_order_date
    FROM Delivery
    GROUP BY customer_id
) first_orders
ON d.customer_id = first_orders.customer_id
AND d.order_date = first_orders.first_order_date;

