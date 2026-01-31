-- Problem: to find the students who have shown improvement. A student is considered to have shown improvement if they meet both of these conditions:

-- Have taken exams in the same subject on at least two different dates
-- Their latest score in that subject is higher than their first score

SELECT
    s.student_id,
    s.subject,
    MAX(CASE WHEN s.exam_date = t.min_date THEN s.score END) AS first_score,
    MAX(CASE WHEN s.exam_date = t.max_date THEN s.score END) AS latest_score
FROM Scores s
JOIN (
    SELECT 
        student_id,
        subject,
        MIN(exam_date) AS min_date,
        MAX(exam_date) AS max_date,
        COUNT(*) AS exam_count
    FROM Scores
    GROUP BY student_id, subject
    HAVING COUNT(*) >= 2
) t
ON s.student_id = t.student_id
AND s.subject = t.subject
GROUP BY s.student_id, s.subject
HAVING latest_score > first_score
ORDER BY s.student_id
