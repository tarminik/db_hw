select count(*) over () as count, firstname, surname
from cd.members
order by joindate, surname, firstname;
