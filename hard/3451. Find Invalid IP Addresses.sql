-- Problem: to find invalid IP addresses. An IPv4 address is invalid if it meets any of these conditions:

-- Contains numbers greater than 255 in any octet
-- Has leading zeros in any octet (like 01.02.03.04)
-- Has less or more than 4 octets

SELECT 
    ip,
    COUNT(*) AS invalid_count
FROM logs
WHERE
    -- Must have exactly 4 parts
    ip NOT REGEXP '^[0-9]+(\\.[0-9]+){3}$'
    
    -- OR any octet greater than 255
    OR CAST(SUBSTRING_INDEX(ip, '.', 1) AS UNSIGNED) > 255
    OR CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(ip, '.', 2), '.', -1) AS UNSIGNED) > 255
    OR CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(ip, '.', 3), '.', -1) AS UNSIGNED) > 255
    OR CAST(SUBSTRING_INDEX(ip, '.', -1) AS UNSIGNED) > 255

    -- OR any octet has leading zeros
    OR SUBSTRING_INDEX(ip, '.', 1) REGEXP '^0[0-9]+'
    OR SUBSTRING_INDEX(SUBSTRING_INDEX(ip, '.', 2), '.', -1) REGEXP '^0[0-9]+'
    OR SUBSTRING_INDEX(SUBSTRING_INDEX(ip, '.', 3), '.', -1) REGEXP '^0[0-9]+'
    OR SUBSTRING_INDEX(ip, '.', -1) REGEXP '^0[0-9]+'

GROUP BY ip
ORDER BY invalid_count DESC, ip DESC;

