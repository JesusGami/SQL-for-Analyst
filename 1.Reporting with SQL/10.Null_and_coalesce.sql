
-- NULL's

-- Show total gold_medals by country
SELECT 
	c.country,
    sum(w.gold) AS gold_medals
FROM winter_games AS w
JOIN countries AS c
ON c.id = w.country_id
GROUP BY 1
-- Order by gold_medals in descending order
ORDER BY 2 desc;



-- Dealing with NULL's with WHERE
SELECT 
	country, 
    SUM(gold) AS gold_medals
FROM winter_games AS w
JOIN countries AS c
ON w.country_id = c.id
-- Removes any row with no gold medals
WHERE w.gold is not null
GROUP BY country
-- Order by gold_medals in descending order
ORDER BY gold_medals DESC;



-- Dealing with NULL's with HAVING
SELECT 
	country, 
    SUM(gold) AS gold_medals
FROM winter_games AS w
JOIN countries AS c
ON w.country_id = c.id
GROUP BY country
-- Replace WHERE statement with equivalent HAVING statement
HAVING sum(gold) is not null
-- Order by gold_medals in descending order
ORDER BY gold_medals DESC;



-- Dealing NULL's with COALESCE
--COALESCE(fieldName,replacement), where replacement is what should replace all null instances of fieldName.

-- Pull events and golds by athlete_id for summer events
SELECT 
    athlete_id,
    count(distinct event) AS total_events, 
    sum(gold) AS gold_medals
FROM summer_games
GROUP BY 1
-- Order by total_events descending and athlete_id ascending
ORDER BY 1 desc, 2 asc;

-- Pull events and golds by athlete_id for summer events
SELECT 
    athlete_id, 
    -- Add a field that averages the existing gold field
    avg(gold) AS avg_golds,
    COUNT(event) AS total_events, 
    SUM(gold) AS gold_medals
FROM summer_games
GROUP BY athlete_id
-- Order by total_events descending and athlete_id ascending
ORDER BY total_events DESC, athlete_id;


-- Pull events and golds by athlete_id for summer events
SELECT 
    athlete_id, 
    -- Replace all null gold values with 0
    avg(coalesce(gold,0)) AS avg_golds,
    COUNT(event) AS total_events, 
    SUM(gold) AS gold_medals
FROM summer_games
GROUP BY athlete_id
-- Order by total_events descending and athlete_id ascending
ORDER BY total_events DESC, athlete_id;