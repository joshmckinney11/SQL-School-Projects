use world;

/*A*/
select name,max(population) as 'Maximum Population',countrycode
from city
group by CountryCode;


/*B*/
select name,max(population) as 'Second Maximum Population',countrycode
from city
where population not in (select max(population)
from city
group by CountryCode)
group by CountryCode;

/*C*/
select c1.name,max(c1.population) as 'Maximum Population',c2.Continent
from city c1 inner join country c2 on c1.countrycode = c2.code
group by C2.Continent;

/*D*/
select name,max(population) as 'Maximum Population',continent
from country
group by Continent;

/*E*/
select continent, sum(population) as 'Population1'
from country 
group by continent
order by population1 desc
limit 1;


/*F*/
select sum(c1.population*c2.percentage) as 'Language Population', c2.language
from country c1 inner join countrylanguage c2 on c1.code = c2.countrycode
group by language;

/*G*/

select cl.language, c.continent, sum(c.population*cl.percentage) as 'NumberPeople'
from countrylanguage cl, country c where c.code=cl.countrycode
group by cl.language, c.continent
having (c.continent, numberpeople) in ( Select
X.continent, max(X.NumberPeople)
from (select cl.language, c.continent,sum(c.population*cl.percentage) as 'NumberPeople'
from countrylanguage cl, country c where c.code=cl.countrycode
group by cl.language, c.continent) X
group by X.continent);


/*H*/
select count(count) as 'Language Count'
from (select Isofficial as count
from countrylanguage
where Isofficial= 'T'
group by Language) t1;

/*I*/
select cl.language, c.continent, sum(c.population*cl.percentage) as 'NumberPeople'
from countrylanguage cl, country c where c.code=cl.countrycode and cl.isofficial = 'T'
group by cl.language, c.continent
having (c.continent, numberpeople) in ( Select
X.continent, max(X.NumberPeople)
from (select cl.language, c.continent,sum(c.population*cl.percentage) as 'NumberPeople'
from countrylanguage cl, country c where c.code=cl.countrycode and cl.isofficial = 'T'
group by cl.language, c.continent) X
group by X.continent);


/*J*/
select cl.countrycode, c.continent, count(*) as 'NumLan'
from countrylanguage cl, country c
where c.code=cl.countrycode and cl.isofficial = 'F'
group by cl.countrycode, c.continent
having (c.continent, count(*)) in (select x.continent, max(X.NumLan)
from(select cl.countrycode, c.continent, count(*) as 'NumLan'
from countrylanguage cl, country c
where c.code=cl.countrycode and cl.isofficial = 'F'
group by cl.countrycode, c.continent) x 
group by x.continent) ;

/*K*/
select * 
from country  
where capital not in  (select ID
from city
where (countrycode,population) in (select countrycode, max(population)
from city group by countrycode));

/*L*/
select * from country 
where population > ( select population from country where name= 'denmark') 
and population < ( select population from country where name= 'Russian Federation')
; 


