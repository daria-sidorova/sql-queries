SELECT 
    ROUND(AVG(total_playtime), 2) AS avg_playtime,
    SUM(last_login < today() - 30) AS churned_players,
    uniqExact(player_id) AS total_players,
    ROUND(100.0 * SUM(last_login < today() - 30) / uniqExact(player_id), 2) AS churn_rate
FROM (
    SELECT 
        p.player_id,
        SUM(s.session_duration) AS total_playtime,
        MAX(s.login_time) AS last_login
    FROM players p
    JOIN player_sessions s ON p.player_id = s.player_id
    GROUP BY p.player_id
);
