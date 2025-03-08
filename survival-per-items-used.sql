WITH player_survival AS (
    SELECT 
        player_id,
        count() AS total_battles,
        countIf(result = 'win') AS wins,
        ROUND(100.0 * wins / NULLIF(total_battles, 0), 2) AS survival_rate
    FROM battles
    GROUP BY player_id
),
item_usage AS (
    SELECT 
        player_id,
        item_type,
        count() AS item_count
    FROM item_usage
    GROUP BY player_id, item_type
)
SELECT 
    ps.player_id,
    ps.survival_rate,
    iu.item_type,
    iu.item_count
FROM player_survival ps
JOIN item_usage iu ON ps.player_id = iu.player_id
ORDER BY ps.survival_rate DESC;
