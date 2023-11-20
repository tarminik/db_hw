select name,
       CASE
           WHEN ntile(3) OVER (ORDER BY sum(summa)) = 1 THEN 'low'
           WHEN ntile(3) OVER (ORDER BY sum(summa)) = 2 THEN 'average'
           WHEN ntile(3) OVER (ORDER BY sum(summa)) = 3 THEN 'high'
           END as revenue
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
order by CASE
             WHEN ntile(3) OVER (ORDER BY sum(summa)) = 1 THEN 3
             WHEN ntile(3) OVER (ORDER BY sum(summa)) = 2 THEN 2
             WHEN ntile(3) OVER (ORDER BY sum(summa)) = 3 THEN 1
             END,
         name;

