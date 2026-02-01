-- Problem: to find books that have polarized opinions - books that receive both very high ratings and very low ratings from different readers.
WITH polar_score AS (
    SELECT 
        book_id,
        COUNT(*) AS session_count,
        MAX(session_rating) AS highest_rating,
        MIN(session_rating) AS lowest_rating,
        MAX(session_rating) - MIN(session_rating) AS rating_spread,
        AVG(CASE 
                WHEN session_rating <= 2 OR session_rating >= 4 
                THEN 1
                ELSE 0
            END) AS polarization_score
    FROM reading_sessions
    GROUP BY book_id
    HAVING COUNT(*) >= 5
       AND MAX(session_rating) >= 4
       AND MIN(session_rating) <= 2
)

SELECT 
    b.book_id,
    b.title,
    b.author,
    b.genre,
    b.pages,
    ps.rating_spread,
    ROUND(ps.polarization_score, 2) AS polarization_score
FROM books b
JOIN polar_score ps
    ON b.book_id = ps.book_id
WHERE ps.polarization_score >= 0.6
ORDER BY polarization_score DESC, b.title DESC;
