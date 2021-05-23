--Exploring the tables
select *
from user_sessions
limit 5;

select *
from user_data
limit 5;


--Joining the tables
select *
from user_sessions us
join user_data ud on us.user_id = ud.user_id
limit 5;




-- Data overview:

-- 1.Average age per country
select 
	country,
	round(avg(age),2) avg_age
from user_sessions us
join user_data ud using(user_id)
group by country;


-- 2.User count by country
select
	country,
	count(distinct user_id) users
from user_sessions 
join user_data using(user_id)
group by country;




-- Active users:
-- The active users KPI counts the active users of a company's app over a certain time period:
	--by day (daily active users, or DAU)
	--by month (monthly active users, or MAU)

-- For example, Facebook had 1.76B DAU and 2.6 MAU in March 2020
--Stickiness (DAU / MAU) measures how often users engage with an app on average. 
--Facebook's stickiness for March was 1.76B / 2.6B ~= 0.677, meaning that, on average, 
--users used Facebook for 67.7% x 30 days ~= 20 days each month.

--To get the daily active users, we need to count the number of unique user_ids for each session_date

-- DAU:
select 
	session_date,
	count(distinct user_id)
from user_sessions
group by 1
order by 1;


--Monthly active users¶
--Usually, reports include MAU, not DAU. How do you convert the session dates to months?

--Enter DATE_TRUNC

--DATE_TRUNC(date_part, date) → DATE: Truncates date to the nearest date_part.

--Examples

--DATE_TRUNC('week', '2018-06-12') :: DATE → '2018-06-11'
--DATE_TRUNC('month', '2018-06-12') :: DATE → '2018-06-01'
--DATE_TRUNC('quarter', '2018-06-12') :: DATE → '2018-04-01'
--DATE_TRUNC('year', '2018-06-12') :: DATE → '2018-01-01'

--Note: :: DATE is just to remove the hours, minutes, and seconds.
select 
	date_trunc('month', session_date) :: date as session_month,
	count(distinct user_id) as users
from user_sessions
group by session_month
order by 1;




--Registration dates
--Let's define the user's registration date as the date of that user's first session.

--So, each user's registration date is the minimum session date for that user in the user_sessions table.

--We'll use these results later on to calculate the growth in registrations.

-- 1.Get each user's registration date
select 
	user_id,
	min(session_date) registration_date
from user_sessions
group by 1
order by 1;




--Registrations and Common Table Expressions (CTEs)
--Now that you have each user's registration date, you'll want to store the results somehow to use them in a 
--different query. How do you do that?

--Enter Common Table Expressions (CTEs)

/*
WITH cte_name AS (
  ...
)


SELECT *
FROM cte_name;

*/
/*
A CTE stores the results of a query temporarily in the specificed cte_name 
so it can be used in the outer query later on.

Once you store the results of the previous query in a CTE, you can DATE_TRUNC() the registration dates 
and count the unique user_ids in each registration month.
*/


-- Store each user's registration date in the regs CTE
-- 1.Calculate the number of registrations per month

WITH regs AS(
	select 
		user_id,
		min(session_date) registration_date
	from user_sessions
	group by 1
)

select 
	date_trunc('month', registration_date) :: date as registration_month,
	count(distinct user_id) as users
from regs
group by 1
order by 1;


select 
	date_trunc('month', registration_date) :: date as registration_month,
	count(distinct user_id) as users
from (select 
		user_id,
		min(session_date) registration_date
	from user_sessions
	group by 1) t 
group by 1
order by 1;




/*
Growth and window functions
You now have each month's registrations. How do you calculate growth?

Growth = (Current month - previous month) / previous month

For example, if you had 122 registrations last month, and you have 156 registrations this month, 
your registrations grew by (156 - 122) / 122 ~= 28% this month.

So you need both the previous and the current months' registrations in the same row. How do you do that?


Window functions

A window function performs some operation across a set of table rows that are somehow related to the current row.

LAG(column_a, 1) OVER (ORDER BY column_b ASC) Gets the previous row's value in column_a if you sort by column_b.
*/


-- 1. Fetch the previous and current months' MAUs
WITH regs AS (
	select 
		user_id,
		min(session_date) registration_date
	from user_sessions
	group by 1
),

	monthly_regs AS (
	select 
		date_trunc('month', registration_date) :: date as registration_month,
		count(distinct user_id) as users
	from regs
	group by 1
),

--select * from monthly_regs;

	prev_regs as (
	select 
		registration_month,
		users,
		lag(users,1) over(order by 1) as prev_reg
	from monthly_regs
	order by 1
)

--select * from prev_regs;

--2. Calculate the monthly growth in registrations
select
	registration_month,
	users,
	round((users - coalesce(prev_reg,0)) :: NUMERIC /coalesce(prev_reg,1), 3) as growth_rate
from prev_regs;




/*
Retained and resurrected users
Users can be split into four groups:

New/registered users are ones that just signed up for your platform
	Retained users used to use your app, and still do, too.
	Churned users used to use your app, and no longer do.
	Resurrected users were churned users who returned to using your app.
	Retention is another core KPI that platforms use to measure how well they are at keeping their users.

The first step to calculating retention is getting each of the months in which each user is active.
*/


--1. Get the months in which each user is active
/*
select 
	distinct date_trunc('month', session_date) as month_active,
	user_id
from user_sessions
order by 1,2;

-- 2.Get whether each user churned in a given month

with act_month as(
	select 
		distinct date_trunc('month', session_date) as month_active,
		user_id
	from user_sessions
)

select 
	prev.user_id,
	prev.month_active prev_month,
	curr.month_active is null as churned_next_month
from act_month as prev
left join act_month as curr on prev.user_id = curr.user_id 
							and prev.month_active = (curr.month_active - INTERVAL '1 MONTH')
--where prev.user_id = 1886 
--where curr.month_active is null
--where prev.user_id in (34,110,147)
where curr.month_active is null;
order by 2,1;
*/


-- 3.Calculate the retention rate

with act_month as(
	select 
		distinct date_trunc('month', session_date) as month_active,
		user_id
	from user_sessions
),

churned as (
	select 
		prev.user_id,
		prev.month_active,
		curr.month_active is null as churned_next_month
	from act_month as prev
	left join act_month as curr on prev.user_id = curr.user_id 
								and prev.month_active = (curr.month_active - INTERVAL '1 MONTH')
	)


select 
	month_active::date,
	count(distinct user_id) as active_users,
	sum(case when churned_next_month then 0 else 1 end) as retained_users,
	round(sum(case when churned_next_month then 0 else 1 end)::numeric / count(distinct user_id),2) as retention_rate
from churned
group by 1
order by 1;

/*
Average age of churners
Now that you have the retention status of each user, you can see whether there are any trends in churns, 
such as older people churning more.
*/


--1. Get the average age of churners versus retained users in April

with act_month as(
	select 
		distinct date_trunc('month', session_date)::date as month_active,
		user_id
	from user_sessions
),

churned as (
	select 
		prev.user_id,
		prev.month_active,
		curr.month_active is null as churned_next_month
	from act_month as prev
	left join act_month as curr on prev.user_id = curr.user_id 
								and prev.month_active = (curr.month_active - INTERVAL '1 MONTH')
	)

select 
	churned_next_month,
	round(avg(age), 2)
from churned 
join user_data using(user_id)
where month_active = '2020-04-01'
group by 1;