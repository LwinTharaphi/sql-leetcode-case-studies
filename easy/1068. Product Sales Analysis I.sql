-- Problem: Reporting the product_name, year, and price for each sale_id in the Sales table.
-- Category: Join tables
-- Insights: Extracting important columns for product sales analysis after joining two talbes.
SELECT p.product_name, s.year, s.price
FROM Sales s 
JOIN Product p ON s.product_id = p.product_id
ORDER BY s.sale_id;