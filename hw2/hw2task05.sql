select surname, firstname, m.memid, min(starttime) as starttime
from cd.members m
         join cd.bookings b on m.memid = b.memid
where starttime >= Date('2012-09-01')
group by surname, firstname, m.memid
order by memid;
