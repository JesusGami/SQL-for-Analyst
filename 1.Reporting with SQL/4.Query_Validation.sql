-- 1. Query validation: Bronze Medals by Country 

-- i.Pull total_bronze_medals from summer_games below
SELECT sum(bronze) AS total_bronze_medals
FROM summer_games;

-- ii.
/* Pull total_bronze_medals from summer_games below
SELECT SUM(bronze) AS total_bronze_medals
FROM summer_games; 
>> OUTPUT = 141 total_bronze_medals */

-- Setup a query that shows bronze_medal by country
SELECT 
	c.country, 
    sum(sm.bronze) AS bronze_medals
FROM summer_games AS sm
JOIN countries AS c
ON sm.country_id = c.id
GROUP BY 1;

-- iii.
-- Select the total bronze_medals from your query
SELECT sum(bronze_medals)
FROM 
-- Previous query is shown below.  Alias this AS subquery
  (SELECT 
      country, 
      SUM(bronze) AS bronze_medals
  FROM summer_games AS s
  JOIN countries AS c
  ON s.country_id = c.id
  GROUP BY country) t
;

-- So, there is no issues with the JOIN