/*
Table: Sales

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| sale_date     | date    |
| fruit         | enum    | 
| sold_num      | int     | 
+---------------+---------+
(sale_date, fruit) is the primary key for this table.
This table contains the sales of "apples" and "oranges" sold each day.
 

Write an SQL query to report the difference between the number of apples and oranges sold each day.

Return the result table ordered by sale_date.

The query result format is in the following example.

 

Example 1:

Input: 
Sales table:
+------------+------------+-------------+
| sale_date  | fruit      | sold_num    |
+------------+------------+-------------+
| 2020-05-01 | apples     | 10          |
| 2020-05-01 | oranges    | 8           |
| 2020-05-02 | apples     | 15          |
| 2020-05-02 | oranges    | 15          |
| 2020-05-03 | apples     | 20          |
| 2020-05-03 | oranges    | 0           |
| 2020-05-04 | apples     | 15          |
| 2020-05-04 | oranges    | 16          |
+------------+------------+-------------+
Output: 
+------------+--------------+
| sale_date  | diff         |
+------------+--------------+
| 2020-05-01 | 2            |
| 2020-05-02 | 0            |
| 2020-05-03 | 20           |
| 2020-05-04 | -1           |
+------------+--------------+
Explanation: 
Day 2020-05-01, 10 apples and 8 oranges were sold (Difference  10 - 8 = 2).
Day 2020-05-02, 15 apples and 15 oranges were sold (Difference 15 - 15 = 0).
Day 2020-05-03, 20 apples and 0 oranges were sold (Difference 20 - 0 = 20).
Day 2020-05-04, 15 apples and 16 oranges were sold (Difference 15 - 16 = -1).
*/

/*solution1*/
select sale_date,
sum(if(fruit='apples', sold_num,-sold_num)) as diff
from Sales 
group by sale_date

/*solution2*/
select sale_date,
sum(case when 
fruit='apples'then sold_num else -sold_num end) as diff
from Sales 
group by sale_date

/*solution3*/
select s1.sale_date,
s2.sold_num - s1.sold_num as diff
from Sales s1 inner join Sales s2
on s1.sale_date = s2.sale_date AND s1.fruit != s2.fruit
group by s1.sale_date

/*solution4*/
select sale_date, sum(if(fruit = 'apples',1,-1)*sold_num) as diff
from sales
group by 1



/*summary:
1. use "IF" flexibly
2. use "CASE WHEN THEN ELSE END" flexibly
3. SELF JOIN
*/