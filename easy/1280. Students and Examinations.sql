-- Problem: To find the number of times each student attended each exam
-- Category: Aggregation with JOIN
-- Insight: Analyzes schools track student participation by showing how many times each student attended exams for each subject, enabling analysis of attendance patterns and identification of students or subjects with low exam participation.
SELECT
    s.student_id,
    s.student_name,
    sub.subject_name,
    COUNT(e.subject_name) AS attended_exams
FROM Students s
CROSS JOIN Subjects sub
LEFT JOIN Examinations e
    ON s.student_id = e.student_id
    AND sub.subject_name = e.subject_name
GROUP BY s.student_id, s.student_name, sub.subject_name
ORDER BY s.student_id, sub.subject_name;



