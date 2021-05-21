-- Filtering: two approaches

--Report with the following characteristics:

/*First column is bronze_medals, or the total number of bronze.
Second column is silver_medals, or the total number of silver.
Third column is gold_medals, or the total number of gold.
Only summer_games are included.
Report is filtered to only include athletes age 16 or under.*/

-- A. WITH JOIN's
SELECT 
	sum(s.bronze) as bronze_medals, 
    sum(s.silver) as silver_medals, 
    sum(s.gold) as gold_medals
FROM summer_games AS s
JOIN athletes AS a
ON s.athlete_id = a.id
-- Filter for athletes age 16 or below
WHERE a.age <= 16;



-- B. WITH SUBQUERY
SELECT 
	sum(bronze) as bronze_medals, 
    sum(silver) as silver_medals, 
    sum(gold) as gold_medals
FROM summer_games
-- Add the WHERE statement below
WHERE athlete_id IN
    -- Create subquery list for athlete_ids age 16 or below    
    (SELECT id
     FROM athletes
     WHERE age <= 16);