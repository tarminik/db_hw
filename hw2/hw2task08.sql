select concat(mems.firstname, ' ', mems.surname) as member, facs.name as facility
from cd.members as mems
         inner join cd.bookings as bs on bs.memid = mems.memid
         inner join cd.facilities as facs on facs.facid = bs.facid and facs.name like 'Tennis Court%'
group by member, facility
order by member, facility

