-- Duplication

/*
To validate a query, take the following steps:

Check the total value of a metric from the original table.
Compare that with the total value of the same metric in your final report.
*/

-- 1. Identifying duplication

-- Pull total gold_medals for winter sports
SELECT sum(gold) as gold_medals
FROM winter_games;



SELECT 
	w.country_id, 
    sum(w.gold) AS gold_medals--, 
    --avg(gdp) AS avg_gdp
FROM winter_games AS w
JOIN country_stats AS c
-- Only join on the country_id fields
ON w.country_id = c.country_id
GROUP BY 1;

select * from country_stats where country_id = 18;



-- Calculate the total gold_medals in your query
SELECT SUM(gold_medals)
FROM
	(SELECT 
     	w.country_id, 
     	SUM(gold) AS gold_medals, 
     	AVG(gdp) AS avg_gdp
    FROM winter_games AS w
    JOIN country_stats AS c
    ON c.country_id = w.country_id
    -- Alias your query as subquery
    GROUP BY w.country_id) AS subquery;
	
	
-- Fixing duplication:
SELECT SUM(gold_medals) AS gold_medals
FROM
	(SELECT 
     	w.country_id, 
     	SUM(gold) AS gold_medals, 
     	AVG(gdp) AS avg_gdp
    FROM winter_games AS w
    JOIN country_stats AS c
    -- Update the subquery to join on a second field
    ON c.country_id = w.country_id and w.year = cast(c.year as date)
    GROUP BY w.country_id) t;