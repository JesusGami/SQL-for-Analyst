-- 1. Exploratory Data Analysis

-- I. 
SELECT bronze
FROM summer_games;

-- II.
SELECT distinct bronze
FROM summer_games;

-- II. Alternative
select bronze
from summer_games
group by 1;

-- III. 
SELECT 
	bronze, 
	count(*) AS rows
FROM summer_games
GROUP BY bronze;