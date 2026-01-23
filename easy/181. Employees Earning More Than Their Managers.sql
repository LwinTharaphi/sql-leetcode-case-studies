-- Problem: Employees Earning More Than Their Managers
-- Category: Self Join
-- Insight: Identifies employees whose pay exceeds their manager, useful for pay equity review.
SELECT 
    e.name AS Employee
FROM Employee e
LEFT JOIN Employee m ON e.managerId = m.id
WHERE e.salary > m.salary