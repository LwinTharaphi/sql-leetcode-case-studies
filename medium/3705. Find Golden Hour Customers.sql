-- Problem: to find golden hour customers - customers who consistently order during peak hours and provide high satisfaction. A customer is a golden hour customer if they meet ALL the following criteria:

-- Made at least 3 orders.
-- At least 60% of their orders are during peak hours (11:00-14:00 or 18:00-21:00).
-- Their average rating for rated orders is at least 4.0, round it to 2 decimal places.
-- Have rated at least 50% of their orders.

WITH details_table AS
    (SELECT
        customer_id,
        COUNT(order_id) AS total_orders,
        ROUND(AVG(
            CASE 
                WHEN TIME(order_timestamp) BETWEEN '11:00:00' AND '14:00:00'
                OR TIME(order_timestamp) BETWEEN '18:00:00' AND '21:00:00'
                THEN 1 ELSE 0
            END
        ) * 100, 0) AS peak_hour_percentage,
        ROUND(AVG(order_rating), 2) AS average_rating,
        SUM(CASE WHEN order_rating IS NOT NULL THEN 1 ELSE 0 END) *100 / COUNT(*) AS order_rating_percentage
    FROM restaurant_orders
    GROUP BY customer_id)


SELECT 
    customer_id,
    total_orders,
    peak_hour_percentage,
    average_rating 
FROM 
    details_table
WHERE 
    total_orders >= 3
    AND peak_hour_percentage >= 60
    AND average_rating >= 4
    AND order_rating_percentage >= 50
ORDER BY average_rating DESC, customer_id DESC


