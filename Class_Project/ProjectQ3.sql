use world;

/*A: the most populated city in each country*/
select name,max(population) as 'Maximum Population',countrycode
from city
group by CountryCode;


/*B: the second most populated city in each country*/
select name,max(population) as 'Second Maximum Population',countrycode
from city
where population not in (select max(population)
from city
group by CountryCode)
group by CountryCode;

/*C: the most populated city in each continent*/
select c1.name,max(c1.population) as 'Maximum Population',c2.Continent
from city c1 inner join country c2 on c1.countrycode = c2.code
group by C2.Continent;

/*D: the most populated country in each continent */
select name,max(population) as 'Maximum Population',continent
from country
group by Continent;

/*E: the most populated continent*/
select continent, sum(population) as 'Population1'
from country 
group by continent
order by population1 desc
limit 1;


/*F: the number of peoople speaking each language*/
select sum(c1.population*c2.percentage) as 'Language Population', c2.language
from country c1 inner join countrylanguage c2 on c1.code = c2.countrycode
group by language;

/*G: the most spoken language in each continent*/

select cl.language, c.continent, sum(c.population*cl.percentage) as 'NumberPeople'
from countrylanguage cl, country c where c.code=cl.countrycode
group by cl.language, c.continent
having (c.continent, numberpeople) in ( Select
X.continent, max(X.NumberPeople)
from (select cl.language, c.continent,sum(c.population*cl.percentage) as 'NumberPeople'
from countrylanguage cl, country c where c.code=cl.countrycode
group by cl.language, c.continent) X
group by X.continent);


/*H: number of languages that they are official languages of at least one country*/
select count(count) as 'Language Count'
from (select Isofficial as count
from countrylanguage
where Isofficial= 'T'
group by Language) t1;

/*I: the most spoken official language based on each continent.*/
select cl.language, c.continent, sum(c.population*cl.percentage) as 'NumberPeople'
from countrylanguage cl, country c where c.code=cl.countrycode and cl.isofficial = 'T'
group by cl.language, c.continent
having (c.continent, numberpeople) in ( Select
X.continent, max(X.NumberPeople)
from (select cl.language, c.continent,sum(c.population*cl.percentage) as 'NumberPeople'
from countrylanguage cl, country c where c.code=cl.countrycode and cl.isofficial = 'T'
group by cl.language, c.continent) X
group by X.continent);


/*J: the country with the most (# of) unofficial languages based on each continent*/
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

/*K: the countries where their capital is not the most populated city in the country*/
select * 
from country  
where capital not in  (select ID
from city
where (countrycode,population) in (select countrycode, max(population)
from city group by countrycode));

/*L: the countries with population smaller than Russia but bigger tham Denmark*/
select * from country 
where population > ( select population from country where name= 'denmark') 
and population < ( select population from country where name= 'Russian Federation')
; 


