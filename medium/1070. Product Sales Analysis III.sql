-- Problem: to find all sales that occurred in the first year each product was sold.
SELECT
    s.product_id, 
    f.first_year,
    s.quantity,
    s.price
FROM
    Sales s
JOIN 
    (SELECT 
        product_id,
        MIN(year) AS first_year
    FROM 
        Sales
    GROUP BY product_id) f
ON s.product_id = f.product_id
AND f.first_year = s.year