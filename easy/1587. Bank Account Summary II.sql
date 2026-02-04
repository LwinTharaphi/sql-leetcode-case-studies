-- Problem: to report the name and balance of users with a balance higher than 10000. The balance of an account is equal to the sum of the amounts of all transactions involving that account.
SELECT
    u.name,
    SUM(amount) AS balance
FROM 
    Users u
JOIN Transactions t
ON u.account = t.account
GROUP BY t.account
HAVING balance > 10000