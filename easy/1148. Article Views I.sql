-- Problem: Finding all the authors that viewed at least one of their own articles
-- Category: Aggregation/ Filtering
-- Insights: Identifies authors engaging with their own content to support engagement tracking and content strategy decisions.
SELECT
    author_id AS id
FROM Views
GROUP BY author_id, viewer_id
HAVING author_id = viewer_id
ORDER BY id
