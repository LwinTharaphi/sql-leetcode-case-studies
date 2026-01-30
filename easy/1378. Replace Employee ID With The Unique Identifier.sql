-- Problem: to show the unique ID of each user, If a user does not have a unique ID replace just show null.

SELECT
    uni.unique_id,
    e.name
FROM Employees e 
LEFT JOIN EmployeeUNI uni
ON e.id = uni.id