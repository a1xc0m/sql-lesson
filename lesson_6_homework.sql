--����� ��: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task1  (lesson6, �������������)
-- SQL: �������� ������� � �������������� ������� (10000 �����, 3 �������, ��� ���� int) � ��������� �� ���������� ������� �� 0 �� 1 000 000. ��������� EXPLAIN �������� � �������� ������� ��������.
df = pd.read_sql('''
with recursive generate_series(r1,r2,r3) as (
    select abs(random() % 1000000) as r1, abs(random() % 1000000) as r2, abs(random() % 1000000) as r3
    union all select abs(random() % 1000000) as r1, abs(random() % 1000000) as r2, abs(random() % 1000000) as r3
    from generate_series
    limit 10000)
select * from generate_series;
''', conn_sqlite)


df.to_sql(name='series', con=conn_sqlite)

--task2 (lesson6, �������������)
-- GCP (Google Cloud Platform): ����� GCP ��������� ������ csv � ���� PSQL �� ������ ���������� (��������� ������ bash � ��������� bash)