select concat(mems.firstname, ' ', mems.surname)                                        as member,
       f.name                                                                           as facility,
       case when b.memid = 0 then b.slots * f.guestcost else b.slots * f.membercost end as cost
from cd.bookings as b,
     cd.members as mems,
     cd.facilities as f
where b.facid = f.facid
  and b.memid = mems.memid
  and b.starttime::date = '2012-09-14'
  and (case when b.memid = 0 then b.slots * f.guestcost else b.slots * f.membercost end) > 30
order by cost desc, member, facility;

