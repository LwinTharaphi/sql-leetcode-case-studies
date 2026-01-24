-- Problem: to find the people who have the most friends and the most friends number.

SELECT 
    id,
    COUNT(id) AS num
FROM
    (SELECT requester_id AS id
    FROM RequestAccepted 
    UNION ALL
    SELECT accepter_id AS id
    FROM RequestAccepted) t
GROUP BY id
ORDER BY COUNT(*) DESC
LIMIT 1
