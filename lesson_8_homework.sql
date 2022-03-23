--task1  (lesson8)
-- oracle: https://leetcode.com/problems/department-top-three-salaries/

--task2  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/17
select member_name, status, sum(amount * unit_price) as costs
from FamilyMembers
join Payments
on FamilyMembers.member_id = Payments.family_member
where years(date) = 2005
group by member_name, status

--task3  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/13
select name
from Passenger
group by name
having count(name) > 1

--task4  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/38
select count(first_name) as count
from Student
where first_name like 'Anna%'

--task5  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/35
select count(classroom) as count
from Schedule
where date = '2019-09-02'

--task6  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/38
select count(first_name) as count
from Student
where first_name like 'Anna%'

--task7  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/32
select floor(avg(year(current_date) - year(birthday))) as age
from FamilyMembers

--task8  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/27
select good_type_name, sum(amount * unit_price) as costs 
from GoodTypes
join Goods 
on GoodTypes.good_type_id = Goods.type
join Payments 
on Goods.id = Payments.good
where year(date) = 2005
group by good_type_name 

--task9  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/37
select MIN(TIMESTAMPDIFF(year, birthday, current_date)) as year 
from Student

--task10  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/44
with t as
(
    select student, class from Class c join Student_in_class sc
    on c.id = sc.class where name like '10%'
)
select floor(max(datediff(now(), birthday) / 365))
as max_year from Student s join t
on s.id = t.student

--task11 (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/20
select fm.status, fm.member_name, sum(p.amount * p.unit_price) as costs
from FamilyMembers as fm
join Payments as p
on fm.member_id = p.family_member
join Goods as g
on p.good = g.good_id
join GoodTypes as gt
on g.type = gt.good_type_id
where good_type_name like 'entertainment'
group by fm.status, fm.member_name

--task12  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/55
delete from Company 
where Company.id in  
 	( 
    select company from Trip 
    group by company 
    having count(id) = (select min(count) from (select count(id) as count from Trip group by company) as min_count) 
    )

--task13  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/45
select classroom
from Schedule
group by classroom
having count(classroom) =
    (select count(classroom)
    from Schedule
    group by classroom
    order by count(classroom) DESC 
    limit 1)

--task14  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/43
select last_name
from Teacher
join Schedule
on Teacher.id = Schedule.teacher
join Subject
on Schedule.subject = Subject.id
where name like 'Physical Culture'
order by last_name

--task15  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/63

--task16  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/40
select name as subjects
from Subject
join Schedule
on Subject.id = Schedule.subject
join Teacher
on Schedule.teacher = Teacher.id
where last_name like 'Romashkin'
and first_name like 'P%'
and middle_name like 'P%'

--task17  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/42
select DISTINCT TIMEDIFF(
    (select end_pair from Timepair where id like '4'),
    (select start_pair from Timepair where id like '2')
    ) as time 
from Timepair

--task18  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/51
insert into Goods
set good_id = (select count(*) + 1 from Goods as a),
    good_name = 'cheese',
    type = (
            select good_type_id 
            from GoodTypes
            where good_type_name = 'food'
            )