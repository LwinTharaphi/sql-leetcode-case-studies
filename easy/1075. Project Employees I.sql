-- Problem: Reporting the average experience years of all the employees for each project
-- Category: Aggregation / Performance Analysis
-- Insight: Evaluates team experience levels per project to support staffing decisions and project planning.
SELECT p.project_id, ROUND(AVG(e.experience_years),2) AS average_years
FROM Project p
JOIN Employee e ON p.employee_id = e.employee_id
GROUP BY p.project_id;
