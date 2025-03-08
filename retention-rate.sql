WITH daily_active_users AS (
    SELECT 
        player_id, 
        toDate(login_time) AS login_date
    FROM player_sessions
    GROUP BY player_id, login_date
),
retention AS (
    SELECT 
        login_date AS day_0,
        uniqExact(player_id) AS new_users,
        uniqExactIf(player_id, player_id IN (
            SELECT player_id FROM daily_active_users da2 WHERE da2.login_date = da1.login_date + 1
        )) AS retained_users,
        ROUND(100.0 * retained_users / new_users, 2) AS retention_rate
    FROM daily_active_users da1
    GROUP BY login_date
)
SELECT * FROM retention
ORDER BY day_0;
