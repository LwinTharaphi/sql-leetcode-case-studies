-- Problem: Joining two tables together to get a combined result set
-- Category: Join Operations
-- Insight: Enables analysis that requires information from multiple entities, supporting more complete business insights.
SELECT 
    Person.firstName, Person.lastName, Address.city, Address.state
FROM Person LEFT JOIN Address ON Person.personId = Address.personId