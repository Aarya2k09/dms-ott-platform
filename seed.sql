-- OTT Platform DMS
-- Sample data for users, plans, content, watch history, favorites

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
