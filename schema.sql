-- OTT Platform DMS
-- Beginner-friendly database schema

DROP TABLE IF EXISTS favorites;
DROP TABLE IF EXISTS watch_history;
DROP TABLE IF EXISTS content_genres;
DROP TABLE IF EXISTS genres;
DROP TABLE IF EXISTS content;
DROP TABLE IF EXISTS subscriptions;
DROP TABLE IF EXISTS plans;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS devices;

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
