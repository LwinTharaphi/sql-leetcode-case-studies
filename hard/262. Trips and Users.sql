-- Problem:  to find the cancellation rate of requests with unbanned users (both client and driver must not be banned) each day between "2013-10-01" and "2013-10-03" with at least one trip.

SELECT 
    t.request_at AS Day,
    ROUND(AVG(CASE WHEN t.status LIKE 'cancelled%' THEN 1 ELSE 0 END),2) AS `Cancellation Rate`
FROM Trips t
JOIN Users c 
    ON t.client_id = c.users_id AND c.role = 'client'
JOIN Users d 
    ON t.driver_id = d.users_id AND d.role = 'driver'
WHERE c.banned = 'No' 
  AND d.banned = 'No'
  AND t.request_at >= '2013-10-01' 
  AND t.request_at <= '2013-10-03'
GROUP BY t.request_at

