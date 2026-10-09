-- OTT Platform DMS
-- Basic example queries for learning SQL

-- 1. Show all users
SELECT * FROM users;

-- 2. Show active users only
SELECT *
FROM users
WHERE status = 'active';

-- 3. Show all plans and prices
SELECT plan_name, monthly_price, max_devices, video_quality
FROM plans;

-- 4. Show active subscriptions with user name and plan
SELECT u.first_name, u.last_name, p.plan_name, s.start_date, s.end_date, s.status
FROM subscriptions s
JOIN users u ON s.user_id = u.user_id
JOIN plans p ON s.plan_id = p.plan_id
WHERE s.status = 'active';

-- 5. Show most watched content
SELECT c.title, COUNT(w.watch_id) AS total_views, SUM(w.watched_minutes) AS total_minutes_watched
FROM content c
LEFT JOIN watch_history w ON c.content_id = w.content_id
GROUP BY c.title
ORDER BY total_minutes_watched DESC;

-- 6. Find favorite content for a user
SELECT u.first_name, c.title
FROM favorites f
JOIN users u ON f.user_id = u.user_id
JOIN content c ON f.content_id = c.content_id
WHERE u.user_id = 1;

-- 7. Show count of users by country
SELECT country, COUNT(*) AS total_users
FROM users
GROUP BY country
ORDER BY total_users DESC;

-- 8. Show content by type
SELECT content_type, COUNT(*) AS total_content
FROM content
GROUP BY content_type;

-- 9. Show devices used by users
SELECT u.first_name, u.last_name, d.device_name, d.device_type
FROM watch_history w
JOIN users u ON w.user_id = u.user_id
JOIN devices d ON w.device_id = d.device_id
GROUP BY u.first_name, u.last_name, d.device_name, d.device_type;

-- 10. Show average watch completion percentage
SELECT ROUND(AVG(completion_percent), 2) AS avg_completion_rate
FROM watch_history;

-- 11. Show users with expired plans
SELECT u.first_name, u.last_name, s.end_date
FROM subscriptions s
JOIN users u ON s.user_id = u.user_id
WHERE s.status = 'expired';

-- 12. Show premium content list
SELECT title, content_type, language
FROM content
WHERE is_premium = TRUE;
