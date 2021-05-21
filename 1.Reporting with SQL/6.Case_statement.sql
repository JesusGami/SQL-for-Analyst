-- 1.Custom column with CASE statement

SELECT 
	name,
    -- Output 'Tall Female', 'Tall Male', or 'Other'
	CASE 
    when height >= 175 and gender = 'F' then 'Tall Female'
    when height >= 190 and gender = 'M' then 'Tall Male'
    else 'Other' END AS segment
FROM athletes;



-- 2. BMI bucket by sport
-- BMI = 100 * weight / (height squared)

-- Pull in sport, bmi_bucket, and athletes
SELECT 
	s.sport,
    -- Bucket BMI in three groups: <.25, .25-.30, and >.30	
    CASE 
		WHEN 100*(a.weight/a.height^2) < .25 THEN '<.25'
		WHEN 100*(a.weight/a.height^2) <=.30 THEN '.25-.30'
		WHEN 100*(a.weight/a.height^2) > .30 THEN '>.30' 
		END AS bmi_bucket,
    count(distinct a.id) AS athletes
FROM summer_games AS s
JOIN athletes AS a
ON s.athlete_id = a.id
-- GROUP BY non-aggregated fields
GROUP BY 1,2
-- Sort by sport and then by athletes in descending order
ORDER BY 1,2 desc;


-- CASE statement: NULL's

-- Show height, weight, and bmi for all athletes
SELECT 
	height,
    weight,
    100*weight/height^2 AS bmi
FROM athletes
-- Filter for NULL bmi values
WHERE 100*weight/height^2 is null;


-- Handling with NULL's

SELECT 
	sport,
	CASE 
		WHEN weight/height^2*100 <.25 THEN '<.25'
		WHEN weight/height^2*100 <=.30 THEN '.25-.30'
		WHEN weight/height^2*100 >.30 THEN '>.30'
		-- Add ELSE statement to output 'no weight recorded'
		else 'no height or weight recorded' 
		END AS bmi_bucket,
    COUNT(DISTINCT athlete_id) AS athletes
FROM summer_games AS s
JOIN athletes AS a
ON s.athlete_id = a.id
GROUP BY sport, bmi_bucket
ORDER BY sport, athletes DESC;

