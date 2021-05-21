-- 1.The base report
-- Query the sport and distinct number of athletes
SELECT 
	sport, 
    count(distinct athlete_id) AS athletes
FROM summer_games
GROUP BY sport
-- Only include the 3 sports with the most athletes
ORDER BY 2 DESC 
LIMIT 3;

--2.Athletes vs events by sport
-- Query sport, events, and athletes from summer_games
SELECT 
	sport, 
    count(distinct event) AS events, 
    count(distinct athlete_id) AS athletes
FROM summer_games
GROUP BY 1;