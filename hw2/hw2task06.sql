select firstname, surname
from cd.members
where memid in (select recommendedby from cd.members)
order by surname, firstname;
