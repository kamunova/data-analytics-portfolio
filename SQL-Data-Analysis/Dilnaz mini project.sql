#1.задание
#Напишите запрос SQL, выводящий одним числом количество уникальных пользователей в этой таблице в период с 2023-11-07 по 2023-11-15.

SELECT COUNT(DISTINCT user_id) AS user_count
FROM users
WHERE date BETWEEN '2023-11-07' AND '2023-11-15';

#Определите пользователя, который за весь период посмотрел наибольшее количество объявлений. 

SELECT user_id, SUM(view_adverts) AS view_counts
FROM users
GROUP BY user_id
ORDER BY view_counts desc
LIMIT 1;

#Определите день с наибольшим средним количеством просмотренных рекламных объявлений на пользователя, но учитывайте только дни с более чем 500 уникальными пользователями.

SELECT date, AVG(view_adverts) AS avg_view
FROM users
GROUP BY date
HAVING COUNT(DISTINCT user_id)>500
ORDER BY avg_view DESC
LIMIT 1;

#Напишите запрос возвращающий LT (продолжительность присутствия пользователя на сайте) по каждому пользователю. Отсортировать LT по убыванию.

SELECT user_id, COUNT(DISTINCT date) AS LT
FROM users
GROUP BY user_id
ORDER BY LT DESC
LIMIT 1;

#Для каждого пользователя подсчитайте среднее количество просмотренной рекламы за день, а затем выясните, у кого самый высокий средний показатель среди тех, кто был активен как минимум в 5 разных дней.

SELECT user_id, AVG(view_adverts) AS avg_views
FROM users
GROUP BY user_id
HAVING  COUNT(DISTINCT date) >= 5
ORDER BY avg_views DESC
LIMIT 1;


#2 задание 

CREATE DATABASE mini_project;
USE mini_project;

CREATE TABLE T_TAB1 (
    ID INT UNIQUE,
    GOODS_TYPE VARCHAR(50),
    QUANTITY INT,
    AMOUNT INT,
    SELLER_NAME VARCHAR(50)
);

INSERT INTO T_TAB1 (ID, GOODS_TYPE, QUANTITY, AMOUNT, SELLER_NAME) VALUES
(1, 'MOBILE PHONE', 2, 400000, 'MIKE'),
(2, 'KEYBOARD', 1, 10000, 'MIKE'),
(3, 'MOBILE PHONE', 1, 50000, 'JANE'),
(4, 'MONITOR', 1, 110000, 'JOE'),
(5, 'MONITOR', 2, 80000, 'JANE'),
(6, 'MOBILE PHONE', 1, 130000, 'JOE'),
(7, 'MOBILE PHONE', 1, 60000, 'ANNA'),
(8, 'PRINTER', 1, 90000, 'ANNA'),
(9, 'KEYBOARD', 2, 10000, 'ANNA'),
(10, 'PRINTER', 1, 80000, 'MIKE');

CREATE TABLE T_TAB2 (
    ID INT UNIQUE,
    NAME VARCHAR(50),
    SALARY INT,
    AGE INT
);

INSERT INTO T_TAB2 (ID, NAME, SALARY, AGE) VALUES
(1, 'ANNA', 110000, 27),
(2, 'JANE', 80000, 25),
(3, 'MIKE', 120000, 25),
(4, 'JOE', 70000, 29),
(5, 'RITA', 120000, 29);

#Напишите запрос, который вернёт список уникальных категорий товаров (GOODS_TYPE). Какое количество уникальных категорий товаров вернёт запрос?

SELECT DISTINCT GOODS_TYPE
FROM t_tab1;

#Напишите запрос, который вернет суммарное количество и суммарную стоимость проданных мобильных телефонов. Какое суммарное количество и суммарную стоимость вернул запрос?

SELECT SUM(QUANTITY) AS SUM_QUANTITY,
SUM(AMOUNT) AS SUM_AMOUNT
FROM t_tab1
WHERE GOODS_TYPE= 'MOBILE PHONE';

#Напишите запрос, который вернёт список сотрудников с заработной платой > 100000. Какое кол-во сотрудников вернул запрос?

SELECT *
FROM t_tab2
WHERE SALARY > 100000;

#Напишите запрос, который вернёт минимальный и максимальный возраст сотрудников, а также минимальную и максимальную заработную плату.

SELECT 
    MAX(AGE) AS MAX_AGE,
    MIN(AGE) AS MIN_AGE,
    MAX(SALARY) AS MAX_SALARY,
    MIN(SALARY) AS MIN_SALARY
FROM
    t_tab2;

#Напишите запрос, который вернёт среднее количество проданных клавиатур и принтеров.

SELECT GOODS_TYPE, AVG( QUANTITY) AS AVG_SALES
FROM t_tab1
GROUP BY GOODS_TYPE
HAVING GOODS_TYPE IN ('KEYBOARD','PRINTER');

#Напишите запрос, который вернёт имя сотрудника и суммарную стоимость проданных им товаров.

SELECT B.NAME, SUM(AMOUNT) AS SALES_AMOUNT
FROM t_tab1 A 
JOIN t_tab2 B
ON A.SELLER_NAME=B.NAME
GROUP BY B.NAME;

#Напишите запрос, который вернёт имя сотрудника, тип товара, кол-во товара, стоимость товара, заработную плату и возраст сотрудника MIKE.

SELECT A.SELLER_NAME, A.GOODS_TYPE, A.QUANTITY, A.AMOUNT,
B.SALARY,B.AGE
FROM t_tab1 A
JOIN t_tab2 B
ON A.SELLER_NAME=B.NAME
WHERE A.SELLER_NAME ='MIKE';

#Напишите запрос, который вернёт имя и возраст сотрудника, который ничего не продал. Сколько таких сотрудников?

SELECT A.NAME, A.AGE 
FROM t_tab2 A
LEFT JOIN t_tab1 B
ON A.NAME=B.SELLER_NAME
WHERE B.SELLER_NAME IS NULL;

#Напишите запрос, который вернёт имя сотрудника и его заработную плату с возрастом меньше 26 лет? Какое количество строк вернул запрос?

SELECT NAME, SALARY
FROM t_tab2
WHERE AGE<26;

#Сколько строк вернёт следующий запрос:

SELECT * FROM T_TAB1 t
JOIN T_TAB2 t2 ON t2.name = t.seller_name
WHERE t2.name = 'RITA';
