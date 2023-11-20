select recommendedby, count(memid) as count
from (select * from cd.members where recommendedby is not null) as "m*"
group by recommendedby
order by recommendedby;
