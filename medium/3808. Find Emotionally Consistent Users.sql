-- to identify emotionally consistent users based on the following requirements:

-- For each user, count the total number of reactions they have given.
-- Only include users who have reacted to at least 5 different content items.
-- A user is considered emotionally consistent if at least 60% of their reactions are of the same type.

SELECT 
    r.user_id,
    r.reaction AS dominant_reaction,
    ROUND(COUNT(*) / total.total_reactions, 2) AS reaction_ratio
FROM 
    reactions r
JOIN
    (SELECT user_id, COUNT(*) AS total_reactions
    FROM reactions
    GROUP BY user_id
    HAVING COUNT(DISTINCT content_id) >= 5) AS total
ON r.user_id = total.user_id
GROUP BY r.user_id, r.reaction, total.total_reactions
HAVING reaction_ratio > 0.6 
ORDER BY reaction_ratio DESC


