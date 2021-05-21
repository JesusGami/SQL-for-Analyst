-- Report 1: Most decorated summer athletes

-- Pull athlete_name and gold_medals for summer games
SELECT 
	a.name AS athlete_name, 
    SUM(s.gold) AS gold_medals
FROM summer_games AS s
JOIN athletes AS a
ON s.athlete_id = a.id
GROUP BY 1
-- Filter for only athletes with 3 gold medals or more
HAVING SUM(s.gold) > 2
-- Sort to show the most gold medals at the top
ORDER BY 2 DESC;