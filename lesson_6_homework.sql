--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task1  (lesson6, дополнительно)
-- SQL: Создайте таблицу с синтетическими данными (10000 строк, 3 колонки, все типы int) и заполните ее случайными данными от 0 до 1 000 000. Проведите EXPLAIN операции и сравните базовые операции.
df = pd.read_sql('''
with recursive generate_series(r1,r2,r3) as (
    select abs(random() % 1000000) as r1, abs(random() % 1000000) as r2, abs(random() % 1000000) as r3
    union all select abs(random() % 1000000) as r1, abs(random() % 1000000) as r2, abs(random() % 1000000) as r3
    from generate_series
    limit 10000)
select * from generate_series;
''', conn_sqlite)


df.to_sql(name='series', con=conn_sqlite)

--task2 (lesson6, дополнительно)
-- GCP (Google Cloud Platform): Через GCP загрузите данные csv в базу PSQL по личным реквизитам (используя только bash и интерфейс bash)