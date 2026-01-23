-- Problem: Delete duplicate email records
-- Category: Data Cleaning / Data Quality
-- Insight: Removes duplicate user records while preserving the earliest entry, improving data accuracy and consistency.

DELETE p1
FROM Person p1
JOIN Person p2
  ON p1.email = p2.email
 AND p1.id > p2.id;
