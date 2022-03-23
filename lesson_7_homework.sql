--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task1  (lesson7)
-- sqlite3: ������� �������� ������ � �� (sqlite3, project name: task1_7). � ������� table1 �������� 1000 ����� � ���������� ���������� (3 �������, ��� int) �� 0 �� 1000.
-- ����� ��������� ����������� ������������� ���� ���� �������

--task2  (lesson7)
-- oracle: https://leetcode.com/problems/duplicate-emails/
SELECT 'Email' 
FROM 'Person'
GROUP BY 'Email'
HAVING COUNT(*) > 1

--task3  (lesson7)
-- oracle: https://leetcode.com/problems/employees-earning-more-than-their-managers/
select Name as Employee 
from Employee e 
where e.ManagerId in (select ID from Employee) 
and e.Salary > 
(
    select  ee.Salary from Employee ee where e.ManagerId=ee.Id
)

--task4  (lesson7)
-- oracle: https://leetcode.com/problems/rank-scores/
SELECT Score, dense_rank() over(ORDER BY Score DESC) AS 'Rank'
FROM Scores

--task5  (lesson7)
-- oracle: https://leetcode.com/problems/combine-two-tables/
SELECT FirstName
	, LastName
	, City
	, State 
FROM Person 
LEFT JOIN Address
	ON Person.personId=Address.personId