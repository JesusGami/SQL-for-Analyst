-- Most decorated athlete per region

select 
	t.region,
	t.athlete_name,
	t.total_golds 
from
	(
	SELECT 
	-- Query region, athlete_name, and total gold medals
	c.region, 
    a.name AS athlete_name, 
    coalesce(sum(s.gold),0) AS total_golds,
    -- Assign a regional rank to each athlete
    row_number() over(partition by c.region order by coalesce(sum(gold),0) desc) AS row_num
	FROM summer_games AS s
	JOIN athletes AS a
	ON a.id = s.athlete_id
	JOIN countries AS c
	ON c.id = s.country_id
	GROUP BY 1,2) t
where t.row_num = 1