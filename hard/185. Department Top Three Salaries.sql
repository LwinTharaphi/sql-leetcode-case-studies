-- Problem: to find the employees who are high earners in each of the departments.
WITH salary_ranking AS
    (SELECT
    id,
    name,
    salary,
    departmentId,
    DENSE_RANK() over (
        PARTITION BY departmentId
        ORDER BY salary DESC
    ) AS salary_rank
    FROM Employee)

SELECT 
    d.name AS Department,
    sr.name AS Employee,
    sr.salary AS Salary
FROM salary_ranking sr
JOIN Department d
ON sr.departmentId = d.id
WHERE sr.salary_rank <= 3




