-- Problem: To find managers with at least five direct reports
SELECT
    name
FROM Employee
JOIN
    (SELECT 
        managerId
    FROM Employee
    GROUP BY managerId
    HAVING COUNT(*) >= 5) AS fiveReportManagers
ON Employee.id = fiveReportManagers.managerId

