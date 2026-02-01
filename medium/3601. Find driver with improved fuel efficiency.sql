-- Problem: to find drivers whose fuel efficiency has improved by comparing their average fuel efficiency in the first half of the year with the second half of the year.

-- Calculate fuel efficiency as distance_km / fuel_consumed for each trip
-- First half: January to June, Second half: July to December
-- Only include drivers who have trips in both halves of the year
-- Calculate the efficiency improvement as (second_half_avg - first_half_avg)
-- Round all results to 2 decimal places
WITH avg_fuel_efficiency AS
    (SELECT
        driver_id,
        AVG(CASE 
                WHEN MONTH(trip_date) BETWEEN 1 AND 6 
                THEN distance_km / fuel_consumed 
            END) AS first_half_avg,
        AVG(CASE 
                WHEN MONTH(trip_date) BETWEEN 7 AND 12 
                THEN distance_km / fuel_consumed 
            END) AS second_half_avg
    FROM trips
    GROUP BY driver_id
    HAVING first_half_avg IS NOT NULL AND second_half_avg IS NOT NULL)

SELECT
    d.driver_id,
    d.driver_name,
    ROUND(a.first_half_avg, 2) AS first_half_avg,
    ROUND(a.second_half_avg, 2) AS second_half_avg,
    ROUND((a.second_half_avg - a.first_half_avg),2) AS efficiency_improvement
FROM drivers d
JOIN avg_fuel_efficiency a 
ON d.driver_id = a.driver_id
WHERE a.second_half_avg > a.first_half_avg
ORDER BY efficiency_improvement DESC, d.driver_name ASC



