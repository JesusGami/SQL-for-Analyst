-- Average total country medals by region

-- Query total_golds by region and country_id
SELECT 
	c.region, 
    s.country_id, 
    sum(s.gold) AS total_golds
FROM summer_games AS s
JOIN countries AS c
ON s.country_id = c.id
GROUP BY 1,2;

-- Pull in avg_total_golds by region
SELECT 
	t.region,
    coalesce(avg(t.total_golds),0) AS avg_total_golds
from
  (SELECT 
      region, 
      country_id, 
      SUM(gold) AS total_golds
  FROM summer_games AS s
  JOIN countries AS c
  ON s.country_id = c.id
  -- Alias the subquery
  GROUP BY region, country_id) AS t
GROUP BY 1
-- Order by avg_total_golds in descending order
ORDER BY 2 desc;