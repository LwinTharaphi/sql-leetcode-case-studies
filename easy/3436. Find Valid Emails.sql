-- Problem: to find all the valid email addresses. A valid email address meets the following criteria:

-- It contains exactly one @ symbol.
-- It ends with .com.
-- The part before the @ symbol contains only alphanumeric characters and underscores.
-- The part after the @ symbol and before .com contains a domain name that contains only letters.

SELECT 
    user_id, email
FROM 
    Users
WHERE 
     email REGEXP '^[A-Za-z0-9_]+@[A-Za-z]+\\.com$'
ORDER BY user_id