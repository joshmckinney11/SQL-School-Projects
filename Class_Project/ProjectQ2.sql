

use ProjectQ2;

start transaction;

delete

t1 from contacts t1
inner join Contacts t2
where t1.id < t2.id 
and t1.first_name = t2.first_name 
and t1.last_name = t2.last_name ;

SELECT * FROM Contacts;

rollback;

