-- Problem: to analyze AI prompt usage patterns
-- Category: Aggregation with GROUP BY and HAVING
-- Insight: identifies active users by showing those who submitted at least three prompts, along with their total prompt count and average tokens used, helping analyze user engagement and usage intensity for optimization or segmentation.
SELECT
    user_id,
    COUNT(*) AS prompt_count,
    ROUND(AVG(tokens),2) AS avg_tokens
FROM
    prompts
GROUP BY
    user_id
HAVING prompt_count >= 3 AND MAX(tokens) > AVG(tokens)
ORDER BY avg_tokens DESC, user_id ASC
