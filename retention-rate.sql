WITH daily_active_users AS (
    SELECT 
        player_id, 
        toDate(login_time) AS login_date
    FROM player_sessions
    GROUP BY player_id, login_date
),
retention AS (
    SELECT 
        day_0.login_date AS day_0,
        uniqExact(day_0.player_id) AS new_users,
        uniqExactIf(day_0.player_id, day_0.player_id IN (
            SELECT player_id FROM daily_active_users da2 WHERE da2.login_date = day_0.login_date + 7
        )) AS retained_users,
        ROUND(100.0 * retained_users / new_users, 2) AS retention_rate
    FROM daily_active_users day_0
    GROUP BY day_0.login_date
)
SELECT * FROM retention
ORDER BY day_0;
