/*
Table: MyNumbers

+-------------+------+
| Column Name | Type |
+-------------+------+
| num         | int  |
+-------------+------+
There is no primary key for this table. It may contain duplicates.
Each row of this table contains an integer.
 

A single number is a number that appeared only once in the MyNumbers table.

Write an SQL query to report the largest single number. If there is no single number, report null.

The query result format is in the following example.

 

Example 1:

Input: 
MyNumbers table:
+-----+
| num |
+-----+
| 8   |
| 8   |
| 3   |
| 3   |
| 1   |
| 4   |
| 5   |
| 6   |
+-----+
Output: 
+-----+
| num |
+-----+
| 6   |
+-----+
Explanation: The single numbers are 1, 4, 5, and 6.
Since 6 is the largest single number, we return it.
Example 2:

Input: 
MyNumbers table:
+-----+
| num |
+-----+
| 8   |
| 8   |
| 7   |
| 7   |
| 3   |
| 3   |
| 3   |
+-----+
Output: 
+------+
| num  |
+------+
| null |
+------+
Explanation: There are no single numbers in the input table so we return null.

*/

/*solution 1*/
select max(a.num) as num 
from
(select num, count(num) as cnt
from mynumbers
group by 1)a
where a.cnt=1

/*solution 2*/
SELECT
    MAX(num) AS num
FROM
    (SELECT
        num
    FROM
        my_numbers
    GROUP BY num
    HAVING COUNT(num) = 1) AS t;

/*summary:
1. Every derived table must have its own alias 二次计算的table要写别名
2. “Where” 是一个约束声明，是在查询结果集返回之前约束来自数据库的数据，
且Where中不能使用聚合函数。 “Having”是一个过滤声明，是在查询结果集返回以
后对查询结果进行的过滤操作，在Having中可以使用聚合函数
WHERE clause is used to specify a condition for filtering records 
before any groupings are made, while the HAVING clause is used to 
specify a condition for filtering values from a group. 
*/