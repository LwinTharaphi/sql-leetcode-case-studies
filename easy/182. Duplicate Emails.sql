-- Problem: Reporting all duplicate emails
-- Category: Data Quality / Aggregation
-- Insight: Identifies duplicate email records to support data cleaning and prevent inconsistencies in user data.
SELECT 
    email as Email
FROM Person
GROUP BY email
Having count(email) > 1