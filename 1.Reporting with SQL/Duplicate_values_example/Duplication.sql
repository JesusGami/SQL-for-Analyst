select p.id, sum(p.points) as points, sum(m.matches_won) as matches_won
from points p
join matches m on p.id = m.id
group by 1;

-- Fixing
select p.id, p.points, sum(m.matches_won) as matches_won
from points p
join matches m on p.id = m.id
group by 1,2;

-- Fixing II
select p.id, p.points, t.matches_won
from points p
join (
	select id, sum(matches_won) as matches_won
	from matches
	group by 1
	) t on t.id = p.id;
	
-- Identifying duplication
select sum(points)
from points;

select sum(points) as total
from (
	select p.id, sum(p.points) as points
	from points p
	join matches m on p.id = m.id
	group by 1) t;

	