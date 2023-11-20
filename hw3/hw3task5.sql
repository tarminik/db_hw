select name, rank() over (order by sum(summa) desc) as rank
from (select name, sum(membercost * slots) as summa
      from cd.facilities f
               join (cd.bookings b join cd.members m on b.memid = m.memid) on f.facid = b.facid
      where surname != 'GUEST'
      group by name
      union
      select name, sum(guestcost * slots) as summa
      from cd.facilities f
               join (cd.bookings b join cd.members m on b.memid = m.memid) on f.facid = b.facid
      where surname = 'GUEST'
      group by name) as subquery
group by name
order by rank,
         name
limit 3;

