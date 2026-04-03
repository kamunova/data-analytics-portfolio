#1
SELECT COUNT(DISTINCT l.user_id)
FROM listenings l
JOIN audiobooks a ON a.uuid = l.audiobook_uuid
WHERE a.title = 'Coraline'
  AND l.is_test = 0
GROUP BY l.user_id, a.duration
HAVING SUM( GREATEST(l.position_to - l.position_from,0)) > a.duration * 0.1;

#2
SELECT
    l.os_name,
    a.title,
    COUNT(DISTINCT l.user_id) AS users_cnt,
    ROUND(SUM(GREATEST(l.position_to - l.position_from,0)) / 3600.0, 2) AS hours_listened
FROM listenings l
JOIN audiobooks a ON a.uuid = l.audiobook_uuid
WHERE l.is_test = 0
GROUP BY l.os_name, a.title
ORDER BY l.os_name, a.title;


#3

SELECT
    a.title,
    COUNT(DISTINCT l.user_id) AS listeners
FROM listenings l
JOIN audiobooks a ON a.uuid = l.audiobook_uuid
WHERE l.is_test = 0
GROUP BY a.title
ORDER BY listeners DESC
LIMIT 1;

#4

SELECT
    a.title,
    COUNT(DISTINCT l.user_id) AS finished_users
FROM listenings l
JOIN audiobooks a ON a.uuid = l.audiobook_uuid
WHERE l.is_test = 0
  AND l.position_to >= a.duration
GROUP BY a.title
ORDER BY finished_users DESC
LIMIT 1;

