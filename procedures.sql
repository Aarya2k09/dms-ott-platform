-- OTT Platform DMS
-- Basic stored procedure for adding a new user and subscription

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

-- Example call:
-- SELECT * FROM create_new_subscription('Meera', 'Khan', 'meera.khan@gmail.com', '9999999999', 'India', 2, '2024-10-01', '2024-11-01');
