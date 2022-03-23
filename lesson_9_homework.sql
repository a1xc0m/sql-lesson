--task1  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/the-report/problem
SELECT
    CASE WHEN
    g.Grade > 7
    THEN s.Name
    ELSE 'NULL' END AS NameOrNull
    , g.Grade
    , s.Marks
FROM Students s
JOIN Grades g
    ON s.Marks BETWEEN g.Min_Mark AND g.Max_Mark
ORDER BY g.Grade DESC, NameOrNull ASC, s.Marks ASC;

--task2  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/occupations/problem
SELECT doctor
    , professor
    , singer,actor
FROM (
    SELECT * FROM (
        SELECT Name
        , occupation
        , (ROW_NUMBER() OVER (PARTITION BY occupation ORDER BY name)) as row_num
        FROM occupations
        ORDER BY name ASC
        ) PIVOT (MIN(name) FOR occupation IN (
            'Doctor' AS doctor
            , 'Professor' AS professor
            , 'Singer' as singer
            , 'Actor' as actor))
        ORDER BY row_num); 
       
--task3  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-9/problem
SELECT DISTINCT CITY
FROM STATION
WHERE NOT (
    CITY LIKE 'A%' OR CITY LIKE 'E%'
    OR CITY LIKE 'I%' OR CITY LIKE 'O%'
    OR CITY LIKE 'U%');
   
--task4  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-10/problem
SELECT DISTINCT CITY
FROM STATION
WHERE lower(
    substr(
        city, length(city), 1))
        NOT IN ('a','e','i','o','u');
       
--task5  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-11/problem
SELECT DISTINCT City
FROM Station
WHERE REGEXP_LIKE(City, '^[^AEIOU]|[^aeiou]$');

--task6  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-12/problem
SELECT DISTINCT City
FROM Station
WHERE REGEXP_LIKE(City, '^[^AEIOU].*[^aeiou]$');

--task7  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/salary-of-employees/problem
SELECT name
FROM Employee
WHERE salary > 2000
    AND months < 10
ORDER BY employee_id;

--task8  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/the-report/problem
SELECT
    CASE WHEN
    g.Grade > 7
    THEN s.Name
    ELSE 'NULL' END AS NameOrNull
    , g.Grade
    , s.Marks
FROM Students s
JOIN Grades g
    ON s.Marks BETWEEN g.Min_Mark AND g.Max_Mark
ORDER BY g.Grade DESC, NameOrNull ASC, s.Marks ASC;