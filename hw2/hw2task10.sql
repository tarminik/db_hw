select concat(m1.firstname, ' ', m1.surname) as member,
       (select concat(m2.firstname, ' ', m2.surname)
        from cd.members as m2
        where m2.memid = m1.recommendedby) as recommender
from cd.members as m1
order by member;
