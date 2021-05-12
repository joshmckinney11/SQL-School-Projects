-- Joshua McKinney

use entertainmentagencyexample;

/*1: Show first name, last name, phone number and full address of customers ( return total 4 columns)*/
select CustFirstName, CustLastName, custphonenumber, concat (custstreetaddress, " ", custcity, ", ", custstate, " ", custzipcode) as 'Address'
from customers;

/*2: Show first name, last name, and state of agents who got hired after December 1998*/
select AgtFirstName, AgtLastName, AgtState
from Agents
where DateHired > '1998-12-31';

/*3: Find customers who like Standards but not Jazz*/
select C.*
from customers c, musical_preferences mp, musical_styles ms
where c.customerid = mp.customerid and mp.styleid = ms.styleid and ms.styleid=21 and c.customerid not in( 
select c.customerid
from customers c, musical_preferences mp, musical_styles ms
where c.customerid = mp.customerid and mp.styleid = ms.styleid and ms.styleid=15);

/*4: Show the entertainers who have no booking*/
select *
from entertainers
where entertainerid not in(
select e.entertainerid
from entertainers e, engagements e2
where e.EntertainerID=e2.EntertainerID);

/*5: show agents who have never booked a Country of Country Rock group*/
select A.*
from agents a, engagements e
where a.AgentID=e.AgentID and a.AgentID not in (
select e.agentid
from engagements e, entertainers e2, entertainer_styles e3, musical_styles m
where e.EntertainerID=e2.EntertainerID and e2.EntertainerID=e3.EntertainerID and e3.styleid=m.styleid and (e3.styleid=11 or e3.styleid=6))
group by A.agentid;

/*6: List the entertainers who played engagement for customers Berg and Hallmark*/
select E2.*
from engagements e, entertainers e2, customers c
where c.CustomerID=e.CustomerID and e.EntertainerID=e2.EntertainerID and c.custlastname = 'Hallmark' and e.entertainerid in (
select e.entertainerid
from engagements e, entertainers e2, customers c
where c.CustomerID=e.CustomerID and e.EntertainerID=e2.EntertainerID and c.custlastname = 'Berg')
group by E.entertainerid;

/*7: Add 5 percent to the salary of agents */
start transaction; 
set sql_safe_updates = 0;
update Agents set salary=salary+salary*0.05;
set sql_safe_updates = 1;
rollback;


/*8: Show the entertainers who have more than two overlapped booking */
Select E.entstagename, e.entertainerid, e1.engagementnumber as 'first booking #', e2.engagementnumber as 'overlapping booking #'
from Entertainers E inner join Engagements E1 on E.EntertainerID = E1.EntertainerID
inner join Engagements E2 on e.EntertainerID = E2.EntertainerID 
where E1.StartDate < E2.StartDate and E1.EndDate > E2.EndDate;

/*9: Is the number of entertainers form Redmond more than the number of entertainers from Auburn?*/
select ( case 
when (select  count(*) from entertainers where entcity='redmond') > (select  count(*) from entertainers where entcity='auburn') then 'More Redmon Entertainers'
when (select  count(*) from entertainers where entcity='redmond') < (select  count(*) from entertainers where entcity='auburn') then 'More Auburn Entertainers'
else 'Same amount of Entertainers'
end) as 'More Redmon of Auburn Entertainers?';


/*10: Show all entertainers and the count of each entertainers engagements*/
select e2.entstagename as 'Entertainer', count(engagementnumber) as 'Number_Engagements'
from engagements e, entertainers e2
where e.entertainerid=e2.entertainerid
group by e.entertainerid;


