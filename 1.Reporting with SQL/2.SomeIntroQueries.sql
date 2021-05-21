-- 1. Age of oldest athlete by region

-- Select the age of the oldest athlete for each region
SELECT 
	c.region, 
    max(a.age) AS age_of_oldest_athlete
FROM athletes a
-- First JOIN statement
JOIN summer_games sm on a.id = sm.athlete_id
-- Second JOIN statement
JOIN countries c on sm.country_id = c.id
GROUP BY c.region;




-- 2. Number of events in each sport

-- Select sport and events for summer sports
SELECT 
	sport, 
    count(distinct event) AS events
FROM summer_games
group by 1
UNION
-- Select sport and events for winter sports
SELECT 
	sport, 
    count(distinct event) as events
FROM winter_games
group by 1
-- Show the most events at the top of the report
order by 2 desc;


