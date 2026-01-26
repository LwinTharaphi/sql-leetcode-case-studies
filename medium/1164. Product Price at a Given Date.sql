-- Problem: to find the prices of all products on the date 2019-08-16.

SELECT 
    p1.product_id,
    CASE 
        WHEN MAX(p2.change_date) IS NULL THEN 10
        ELSE (
            SELECT p3.new_price
            FROM Products p3
            WHERE p3.product_id = p1.product_id
              AND p3.change_date = MAX(p2.change_date)
        )
    END AS price
FROM Products p1
LEFT JOIN Products p2
    ON p1.product_id = p2.product_id
   AND p2.change_date <= '2019-08-16'
GROUP BY p1.product_id;
