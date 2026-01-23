-- Problem: To find the nth highest distinct salary from the Employee table. If there are less than n distinct salaries, return null.
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
      SELECT MAX(e1.salary)
      FROM Employee e1
      WHERE (
          SELECT COUNT(DISTINCT e2.salary)
          FROM Employee e2
          WHERE e2.salary >= e1.salary
      ) = N
  );
END

