-- Problem: to find the person_name of the last person that can fit on the bus without exceeding the weight limit. The test cases are generated such that the first person does not exceed the weight limit.
SELECT
    person_name
FROM
    (SELECT 
        person_name,
        SUM(weight) OVER (ORDER BY turn) AS total_weight
    FROM Queue) t
WHERE total_weight <= 1000
ORDER BY total_weight DESC
LIMIT 1