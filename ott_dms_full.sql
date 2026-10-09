-- =========================================================
-- OTT Platform DMS - Complete Single SQL File
-- Beginner-friendly project for diploma students
-- PostgreSQL compatible
-- =========================================================

DROP TABLE IF EXISTS favorites;
DROP TABLE IF EXISTS watch_history;
DROP TABLE IF EXISTS content_genres;
DROP TABLE IF EXISTS genres;
DROP TABLE IF EXISTS content;
DROP TABLE IF EXISTS subscriptions;
DROP TABLE IF EXISTS plans;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS devices;

-- =========================================================
-- 1. CREATE TABLES
-- =========================================================

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    country VARCHAR(50),
    signup_date DATE DEFAULT CURRENT_DATE,
    status VARCHAR(20) DEFAULT 'active'
);

CREATE TABLE plans (
    plan_id SERIAL PRIMARY KEY,
    plan_name VARCHAR(50) UNIQUE NOT NULL,
    monthly_price NUMERIC(8,2) NOT NULL,
    max_devices INT NOT NULL,
    video_quality VARCHAR(30) NOT NULL
);

CREATE TABLE subscriptions (
    subscription_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users(user_id),
    plan_id INT NOT NULL REFERENCES plans(plan_id),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL CHECK (status IN ('active', 'expired', 'cancelled')),
    auto_renew BOOLEAN DEFAULT TRUE
);

CREATE TABLE content (
    content_id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    content_type VARCHAR(20) NOT NULL CHECK (content_type IN ('movie', 'series', 'documentary', 'live')),
    release_year INT,
    duration_minutes INT,
    language VARCHAR(50),
    age_rating VARCHAR(10),
    is_premium BOOLEAN DEFAULT FALSE
);

CREATE TABLE genres (
    genre_id SERIAL PRIMARY KEY,
    genre_name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE content_genres (
    content_id INT NOT NULL REFERENCES content(content_id),
    genre_id INT NOT NULL REFERENCES genres(genre_id),
    PRIMARY KEY (content_id, genre_id)
);

CREATE TABLE devices (
    device_id SERIAL PRIMARY KEY,
    device_name VARCHAR(100) NOT NULL,
    device_type VARCHAR(30) NOT NULL CHECK (device_type IN ('mobile', 'tablet', 'laptop', 'smart_tv')),
    os_name VARCHAR(50)
);

CREATE TABLE watch_history (
    watch_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users(user_id),
    content_id INT NOT NULL REFERENCES content(content_id),
    device_id INT REFERENCES devices(device_id),
    watched_minutes INT NOT NULL,
    watched_date DATE DEFAULT CURRENT_DATE,
    completion_percent NUMERIC(5,2) DEFAULT 0
);

CREATE TABLE favorites (
    favorite_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users(user_id),
    content_id INT NOT NULL REFERENCES content(content_id),
    added_date DATE DEFAULT CURRENT_DATE,
    UNIQUE (user_id, content_id)
);

CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_subscriptions_user_id ON subscriptions(user_id);
CREATE INDEX idx_watch_user_id ON watch_history(user_id);
CREATE INDEX idx_watch_content_id ON watch_history(content_id);

-- =========================================================
-- 2. INSERT SAMPLE DATA
-- =========================================================

INSERT INTO users (first_name, last_name, email, phone, country, signup_date, status) VALUES
('Aarav', 'Sharma', 'aarav.sharma@gmail.com', '9876543210', 'India', '2024-01-15', 'active'),
('Riya', 'Patel', 'riya.patel@gmail.com', '9876543211', 'India', '2024-02-10', 'active'),
('Kabir', 'Nair', 'kabir.nair@gmail.com', '9876543212', 'India', '2023-12-05', 'inactive'),
('Sneha', 'Roy', 'sneha.roy@gmail.com', '9876543213', 'India', '2024-03-20', 'active'),
('Dev', 'Singh', 'dev.singh@gmail.com', '4155550101', 'USA', '2024-04-01', 'active');

INSERT INTO plans (plan_name, monthly_price, max_devices, video_quality) VALUES
('Basic', 149.00, 1, 'SD'),
('Standard', 249.00, 2, 'HD'),
('Premium', 399.00, 4, 'Full HD'),
('Ultra', 599.00, 5, '4K');

INSERT INTO subscriptions (user_id, plan_id, start_date, end_date, status, auto_renew) VALUES
(1, 4, '2024-09-01', '2024-10-01', 'active', TRUE),
(2, 3, '2024-08-15', '2024-09-15', 'active', TRUE),
(3, 1, '2024-01-01', '2024-02-01', 'expired', FALSE),
(4, 2, '2024-09-10', '2024-10-10', 'active', TRUE),
(5, 4, '2024-09-20', '2024-10-20', 'active', TRUE);

INSERT INTO content (title, content_type, release_year, duration_minutes, language, age_rating, is_premium) VALUES
('The Night Shift', 'series', 2024, 48, 'English', 'PG-13', TRUE),
('Midnight Run', 'movie', 2023, 120, 'English', 'PG-13', TRUE),
('Village of Echoes', 'series', 2022, 52, 'Hindi', 'R', FALSE),
('The Himalayan Trail', 'documentary', 2021, 90, 'Hindi', 'PG', FALSE),
('World Cup Live', 'live', 2026, 180, 'English', 'PG', TRUE),
('The Last Signal', 'movie', 2025, 110, 'English', 'PG-13', TRUE),
('Dhoom City', 'series', 2023, 45, 'Hindi', 'PG-13', FALSE),
('The Blue Horizon', 'movie', 2020, 135, 'English', 'PG', FALSE);

INSERT INTO genres (genre_name) VALUES
('Action'),
('Drama'),
('Thriller'),
('Documentary'),
('Sports'),
('Sci-Fi'),
('Adventure'),
('Crime');

INSERT INTO content_genres (content_id, genre_id) VALUES
(1, 2), (1, 3),
(2, 1), (2, 3),
(3, 2), (3, 3),
(4, 4), (4, 7),
(5, 5),
(6, 6), (6, 7),
(7, 2), (7, 8),
(8, 2), (8, 7);

INSERT INTO devices (device_name, device_type, os_name) VALUES
('Aarav Phone', 'mobile', 'iOS'),
('Living Room TV', 'smart_tv', 'WebOS'),
('Riya Tablet', 'tablet', 'Android'),
('Kabir Laptop', 'laptop', 'Windows'),
('Dev Console', 'smart_tv', 'tvOS');

INSERT INTO watch_history (user_id, content_id, device_id, watched_minutes, watched_date, completion_percent) VALUES
(1, 1, 1, 35, '2024-09-02', 72.92),
(1, 2, 2, 90, '2024-09-04', 75.00),
(2, 1, 3, 48, '2024-09-05', 100.00),
(2, 4, 3, 60, '2024-09-06', 66.67),
(3, 7, 4, 30, '2024-09-07', 66.67),
(4, 5, 2, 150, '2024-09-08', 83.33),
(5, 6, 5, 110, '2024-09-09', 100.00),
(5, 8, 5, 120, '2024-09-10', 88.89);

INSERT INTO favorites (user_id, content_id, added_date) VALUES
(1, 2, '2024-09-04'),
(1, 8, '2024-09-06'),
(2, 1, '2024-09-05'),
(2, 4, '2024-09-07'),
(4, 5, '2024-09-08'),
(5, 6, '2024-09-09');

-- =========================================================
-- 3. CREATE VIEWS
-- =========================================================

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

-- =========================================================
-- 4. CREATE SIMPLE PROCEDURE
-- =========================================================

CREATE OR REPLACE FUNCTION create_new_subscription(
    p_first_name VARCHAR,
    p_last_name VARCHAR,
    p_email VARCHAR,
    p_phone VARCHAR,
    p_country VARCHAR,
    p_plan_id INT,
    p_start_date DATE,
    p_end_date DATE
)
RETURNS TABLE (
    user_id INT,
    subscription_id INT,
    plan_name VARCHAR
) AS $$
DECLARE
    v_user_id INT;
    v_sub_id INT;
    v_plan_name VARCHAR;
BEGIN
    INSERT INTO users(first_name, last_name, email, phone, country, signup_date)
    VALUES (p_first_name, p_last_name, p_email, p_phone, p_country, CURRENT_DATE)
    RETURNING user_id INTO v_user_id;

    INSERT INTO subscriptions(user_id, plan_id, start_date, end_date, status, auto_renew)
    VALUES (v_user_id, p_plan_id, p_start_date, p_end_date, 'active', TRUE)
    RETURNING subscription_id INTO v_sub_id;

    SELECT plan_name INTO v_plan_name
    FROM plans
    WHERE plan_id = p_plan_id;

    RETURN QUERY
    SELECT v_user_id, v_sub_id, v_plan_name;
END;
$$ LANGUAGE plpgsql;

-- =========================================================
-- 5. SAMPLE REPORTS / QUERIES
-- =========================================================

-- 1. Show all users
SELECT * FROM users;

-- 2. Show active users only
SELECT *
FROM users
WHERE status = 'active';

-- 3. Show all plans and prices
SELECT plan_name, monthly_price, max_devices, video_quality
FROM plans;

-- 4. Show active subscriptions with user details
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

-- 6. Show favorite content for a user
SELECT u.first_name, c.title
FROM favorites f
JOIN users u ON f.user_id = u.user_id
JOIN content c ON f.content_id = c.content_id
WHERE u.user_id = 1;

-- 7. Count users by country
SELECT country, COUNT(*) AS total_users
FROM users
GROUP BY country
ORDER BY total_users DESC;

-- 8. Count content by type
SELECT content_type, COUNT(*) AS total_content
FROM content
GROUP BY content_type;

-- 9. Show which devices were used for watching
SELECT u.first_name, u.last_name, d.device_name, d.device_type
FROM watch_history w
JOIN users u ON w.user_id = u.user_id
JOIN devices d ON w.device_id = d.device_id
GROUP BY u.first_name, u.last_name, d.device_name, d.device_type;

-- 10. Show average completion percentage
SELECT ROUND(AVG(completion_percent), 2) AS avg_completion_rate
FROM watch_history;

-- 11. Show expired subscriptions
SELECT u.first_name, u.last_name, s.end_date
FROM subscriptions s
JOIN users u ON s.user_id = u.user_id
WHERE s.status = 'expired';

-- 12. Show premium content
SELECT title, content_type, language
FROM content
WHERE is_premium = TRUE;

-- =========================================================
-- 6. EXAMPLE CALL TO PROCEDURE
-- =========================================================

SELECT *
FROM create_new_subscription('Meera', 'Khan', 'meera.khan@gmail.com', '9999999999', 'India', 2, '2024-10-01', '2024-11-01');

-- End of file
