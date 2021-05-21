-- Report 2: Top athletes in nobel-prized countries

/*
Report Details:

Column 1 should be event, which represents the Olympic event. Both summer and winter events should be included.
Column 2 should be gender, which represents the gender of athletes in the event.
Column 3 should be athletes, which represents the unique athletes in the event.
Athletes from countries that have had no nobel_prize_winners should be excluded.
The report should contain 10 events, where events with the most athletes show at the top.
*/

SELECT 
    event,
    -- Add the gender field below
    CASE 
		when event like '%Women%' then 'female' 
		else 'male' 
		end as gender,
    COUNT(DISTINCT athlete_id) AS athletes
FROM summer_games
-- Only include countries that won a nobel prize
WHERE country_id IN 
	(SELECT country_id 
    FROM country_stats 
    WHERE nobel_prize_winners > 0)
GROUP BY 1
-- Add the second query below and combine with a UNION
UNION
SELECT 
	event,
    case 
		when event like '%Women%' then 'female'
		else 'male' 
		end as gender,
	count(distinct athlete_id) as athletes
FROM summer_games
WHERE country_id IN 
	(SELECT country_id
    FROM country_stats
    WHERE nobel_prize_winners > 0)
GROUP BY 1
-- Order and limit the final output
ORDER BY athletes desc
LIMIT 10;
