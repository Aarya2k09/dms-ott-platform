-- OTT Platform DMS
-- Simple views for reporting

CREATE VIEW active_subscription_view AS
SELECT u.user_id, u.first_name, u.last_name, p.plan_name, p.monthly_price, s.start_date, s.end_date
FROM subscriptions s
JOIN users u ON s.user_id = u.user_id
JOIN plans p ON s.plan_id = p.plan_id
WHERE s.status = 'active';

CREATE VIEW popular_content_view AS
SELECT c.title, c.content_type, COUNT(w.watch_id) AS total_views
FROM content c
LEFT JOIN watch_history w ON c.content_id = w.content_id
GROUP BY c.title, c.content_type
ORDER BY total_views DESC;

CREATE VIEW user_watch_summary AS
SELECT u.user_id, u.first_name, u.last_name,
       COUNT(w.watch_id) AS watch_count,
       SUM(w.watched_minutes) AS total_minutes_watched
FROM users u
LEFT JOIN watch_history w ON u.user_id = w.user_id
GROUP BY u.user_id, u.first_name, u.last_name;
