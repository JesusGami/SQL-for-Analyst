
-- Complex calculations

-- WINDOW FUNCTIONS: FUNCTION(value) OVER (PARTITION BY field ORDER BY field)

-- Total bronze medals
select 
	country_id,
	athlete_id,
	sum(bronze) over() as total_bronze
from summer_games;

-- Country bronze medals
select 
	country_id,
	athlete_id,
	sum(bronze) over(partition by country_id) as total_bronze
from summer_games;

-- Layered calculations
select max(bronze_medals)
from (
	select 
		country_id,
		sum(bronze) as bronze_medals
	from summer_games
	group by country_id
	) t;
	