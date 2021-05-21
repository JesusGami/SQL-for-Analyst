-- 1.Approaches to create the same query

--query:
--Your goal is to create a report with the following fields:

--season, which outputs either summer or winter
--country
--events, which shows the unique number of events


-- A. FIRST JOIN THEN UNION

-- Query season, country, and events for all summer events
SELECT 
	'summer' AS season, 
    c.country, 
    count(distinct event) AS events
FROM summer_games AS s
JOIN countries AS c
ON s.country_id = c.id
GROUP BY 2
-- Combine the queries
UNION 
-- Query season, country, and events for all winter events
SELECT 
	'winter' AS season, 
    c.country, 
    count(distinct event) AS events
FROM winter_games AS w
JOIN countries AS c
ON w.country_id = c.id
GROUP BY 2
-- Sort the results to show most events at the top
ORDER BY 3 desc;




-- B.FIRST UNION THEN JOIN

-- Add outer layer to pull season, country and unique events
SELECT 
	t.season, 
    c.country, 
    count(distinct t.event) AS events
FROM
    -- Pull season, country_id, and event for both seasons
    (SELECT 
     	'summer' AS season, 
     	country_id, 
     	event
    FROM summer_games
    union
    SELECT 
     	'winter' AS season, 
     	country_id, 
     	event
    FROM winter_games) AS t
JOIN countries AS c
ON c.id = t.country_id
-- Group by any unaggregated fields
GROUP BY 1,2
-- Order to show most events at the top
ORDER BY 3 desc;




