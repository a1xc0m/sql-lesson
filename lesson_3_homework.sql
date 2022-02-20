--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing

--task1
--Корабли: Для каждого класса определите число кораблей этого класса, потопленных в сражениях. Вывести: класс и число потопленных кораблей.
select classes.class, count(outcomes.ship)
from outcomes
join ships
on outcomes.ship = ships.name
join classes
on ships.class = classes.class
where outcomes.result = 'sunk'
group by classes.class
union
select classes.class, count(outcomes.ship)
from outcomes
join classes
on outcomes.ship = classes.class
where outcomes.result = 'sunk'
group by classes.class
union
select classes.class, 0
from classes

---------------------------------

select *
from outcomes, ships

---------------------------------

select a.class, sum(a.count)
from
(
	select classes.class, count(outcomes.ship) 
	from outcomes
	join ships
	on outcomes.ship = ships.name 
	join classes
	on ships.class = classes.class
	where outcomes.result = 'sunk'
	group by classes.class
union
	select classes.class, count(outcomes.ship)
	from outcomes
	join classes
	on outcomes.ship = classes.class
	where outcomes.result = 'sunk'
	group by classes.class
union
	select classes.class, 0
	from classes
) a
group by a.class

--task2
--Корабли: Для каждого класса определите год, когда был спущен на воду первый корабль этого класса. Если год спуска на воду головного корабля неизвестен, определите минимальный год спуска на воду кораблей этого класса. 
--Вывести: класс, год.


select classes.class, a.year
from classes
join 
(
	select class, min(launched) as year
	from ships
	group by class
) a
on classes.class = a.class

--------------------------------

select a.class, name, launched years
from
(
	select classes.class, name, launched
	from classes
	join ships
	on classes.class = ships.class
) a

--------------------------------

select launched,
case when launched = (select max(launched) from ships)
	then launched
	else 0
end flag
from ships

---------------------------------

select *
from
(
	select *
	from classes
	join ships
	on classes.class = ships.name	
)

--------------------------------

--task3
--Корабли: Для классов, имеющих потери в виде потопленных кораблей и не менее 3 кораблей в базе данных, вывести имя класса и число потопленных кораблей.


--task4
--Корабли: Найдите названия кораблей, имеющих наибольшее число орудий среди всех кораблей такого же водоизмещения (учесть корабли из таблицы Outcomes).


--task5
--Компьютерная фирма: Найдите производителей принтеров, которые производят ПК с наименьшим объемом RAM и с самым быстрым процессором среди всех ПК, имеющих наименьший объем RAM. Вывести: Maker
