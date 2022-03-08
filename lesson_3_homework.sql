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

---

select *
from outcomes, ships

---

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

---

with min_launch as 
(
	select class, min(launched) as year
	from ships
	group by class
) 
select classes.class, min_launch as year
from classes
join min_launch
on classes.class = min_launch.class

---

select a.class, name, launched years
from
(
	select classes.class, name, launched
	from classes
	join ships
	on classes.class = ships.class
) a

---

--task3
--Корабли: Для классов, имеющих потери в виде потопленных кораблей и не менее 3 кораблей в базе данных, вывести имя класса и число потопленных кораблей.

SELECT c.class, SUM(sh.sunked)
FROM classes c
  JOIN (
     SELECT t.name AS name, t.class AS class,
           CASE WHEN o.result = 'sunk' 
           THEN 1 
           ELSE 0 
           END AS sunked
     FROM
     (
      SELECT name, class
      FROM ships
       UNION
      SELECT ship, ship
      FROM outcomes
     )
     AS t
    left JOIN outcomes o ON t.name = o.ship
  ) sh ON sh.class = c.class
GROUP BY c.class
HAVING COUNT(DISTINCT sh.name) >= 3 AND SUM(sh.sunked) > 0

--task4
--Корабли: Найдите названия кораблей, имеющих наибольшее число орудий среди всех кораблей такого же водоизмещения (учесть корабли из таблицы Outcomes).
select name
from (select O.ship as name, numGuns, displacement
from Outcomes O inner join
Classes C on O.ship = C.class and
O.ship not in (select name
from Ships
)
union
select S.name as name, numGuns, displacement
from Ships S inner join
Classes C on S.class = C.class
) OS inner join
(select max(numGuns) as MaxNumGuns, displacement
from Outcomes O inner join
Classes C on O.ship = C.class and
O.ship not in (select name
from Ships
)
group by displacement
union
select max(numGuns) as MaxNumGuns, displacement
from Ships S inner join
Classes C on S.class = C.class
group by displacement
) GD on OS.numGuns = GD.MaxNumGuns and
OS.displacement = GD.displacement


--task5
--Компьютерная фирма: Найдите производителей принтеров, которые производят ПК с наименьшим объемом RAM и с самым быстрым процессором среди всех ПК, имеющих наименьший объем RAM. Вывести: Maker
SELECT DISTINCT maker
FROM product
WHERE model IN (
SELECT model
FROM pc
WHERE ram = (
  SELECT MIN(ram)
  FROM pc
  )
AND speed = (
  SELECT MAX(speed)
  FROM pc
  WHERE ram = (
   SELECT MIN(ram)
   FROM pc
   )
  )
)
AND
maker IN (
SELECT maker
FROM product
WHERE type='printer'
)
