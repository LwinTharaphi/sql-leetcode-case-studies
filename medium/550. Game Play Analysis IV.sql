-- Problem: to report the fraction of players that logged in again on the day after the day they first logged in, rounded to 2 decimal places.
SELECT 
    ROUND(
        (
            SELECT COUNT(DISTINCT a1.player_id)
            FROM Activity a1
            JOIN Activity a2
              ON a1.player_id = a2.player_id
             AND a2.event_date = DATE_ADD(a1.event_date, INTERVAL 1 DAY)
            WHERE a1.event_date = (
                SELECT MIN(event_date)
                FROM Activity
                WHERE player_id = a1.player_id
            )
        ) / COUNT(DISTINCT player_id),
        2
    ) AS fraction
FROM Activity;