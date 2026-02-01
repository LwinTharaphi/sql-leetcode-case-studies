-- Problem: to find stores that have inventory imbalance - stores where the most expensive product has lower stock than the cheapest product.
WITH price_diff_details AS
    (SELECT
        store_id,
        COUNT(product_name) AS no_of_products,
        MAX(CASE WHEN price = max_price THEN product_name END) AS most_exp_product,
        MAX(CASE WHEN price = min_price THEN product_name END) AS cheapest_product,
        MAX(CASE WHEN price = max_price THEN quantity END) AS most_exp_quantity,
        MAX(CASE WHEN price = min_price THEN quantity END) AS cheapest_quantity,
        ROUND(
            MAX(CASE WHEN price = min_price THEN quantity END) / 
            MAX(CASE WHEN price = max_price THEN quantity END), 2) 
            As imbalance_ratio
    FROM (
        SELECT
            i.*,
            MAX(price) OVER (PARTITION BY store_id) AS max_price,
            MIN(price) OVER (PARTITION BY store_id) AS min_price
        FROM inventory i
    ) t
    GROUP BY store_id)


SELECT 
    s.store_id,
    s.store_name,
    s.location,
    pdd.most_exp_product,
    pdd.cheapest_product,
    pdd.imbalance_ratio
FROM stores s
JOIN price_diff_details pdd
ON s.store_id = pdd.store_id
WHERE pdd.no_of_products >= 3
AND pdd.imbalance_ratio > 1
ORDER BY pdd.imbalance_ratio DESC, s.store_name ASC

