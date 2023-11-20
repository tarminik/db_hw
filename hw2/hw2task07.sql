select m1.firstname as memfname, m1.surname as memsname, m2.firstname as recfname, m2.surname as recsname
from cd.members as m1
         left join cd.members as m2 on m1.recommendedby = m2.memid
order by m1.surname, m1.firstname;

