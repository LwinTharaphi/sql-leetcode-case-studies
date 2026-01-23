-- Problem: To find all books that are currently borrowed (not returned) and have zero copies available in the library
-- Category: JOIN with Aggregation and HAVING
-- Insight: identify books that are fully checked out with no copies available, enabling better inventory management decisions such as prioritizing returns, placing holds, or purchasing additional copies to meet demand.

SELECT 
    b.book_id,
    b.title,
    b.author,
    b.genre,
    b.publication_year,
    COUNT(r.record_id) AS current_borrowers
FROM library_books b
JOIN borrowing_records r
    ON b.book_id = r.book_id
WHERE r.return_date IS NULL
GROUP BY 
    b.book_id,
    b.title,
    b.author,
    b.genre,
    b.publication_year,
    b.total_copies
HAVING COUNT(r.record_id) = b.total_copies
ORDER BY current_borrowers DESC, b.title ASC;
