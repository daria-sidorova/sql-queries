WITH revenue_per_user AS (
    SELECT 
        p.player_id,
        SUM(t.amount) AS total_revenue
    FROM players p
    LEFT JOIN transactions t ON p.player_id = t.player_id
    GROUP BY p.player_id
),
active_user_count AS (
    SELECT 
        COUNT(DISTINCT player_id) AS active_user_count
    FROM transactions
)
SELECT 
    rpu.player_id,
    rpu.total_revenue,
    ROUND(rpu.total_revenue / auc.active_user_count, 2) AS ARPU
FROM revenue_per_user rpu
CROSS JOIN active_user_count auc
ORDER BY rpu.total_revenue DESC;
