/*
Table: Enrollments

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| student_id    | int     |
| course_id     | int     |
| grade         | int     |
+---------------+---------+
(student_id, course_id) is the primary key of this table.
 

Write a SQL query to find the highest grade with its corresponding course for each student. In case of a tie, you should find the course with the smallest course_id.

Return the result table ordered by student_id in ascending order.

The query result format is in the following example.

 

Example 1:

Input: 
Enrollments table:
+------------+-------------------+
| student_id | course_id | grade |
+------------+-----------+-------+
| 2          | 2         | 95    |
| 2          | 3         | 95    |
| 1          | 1         | 90    |
| 1          | 2         | 99    |
| 3          | 1         | 80    |
| 3          | 2         | 75    |
| 3          | 3         | 82    |
+------------+-----------+-------+
Output: 
+------------+-------------------+
| student_id | course_id | grade |
+------------+-----------+-------+
| 1          | 2         | 99    |
| 2          | 2         | 95    |
| 3          | 3         | 82    |
+------------+-----------+-------+
*/

/*solution 1*/
select a.student_id, b.course_id, a.grade
from
(select student_id, max(grade) as grade
from Enrollments
group by 1)a
join 
(select student_id,grade, min(course_id) as course_id
from Enrollments
group by 1,2)b
on a.student_id=b.student_id and a.grade=b.grade
order by a.student_id

/*solution 2*/ 用于多个排序，有先后满足顺序
select a.student_id, a.course_id, a.grade
from 
(select *, rank() over(partition by student_id order by grade desc, course_id) as rnk
from Enrollments) a
where a.rnk = 1
order by a.student_id

/*summary:
1. need min(course_id) as course_id, alias3
2. rank() over(partition by 
https://www.cnblogs.com/xyhero/p/3484c97b362717d0a35fdb3621ab97a9.html 

*/

第二次做：
with new as(select student_id,course_id,grade,dense_rank() over(partition by student_id order by grade desc ,course_id asc) as ranking 
from enrollments)
select student_id,course_id, grade
from new 
where ranking=1

RANK()为您提供有序分区内的排名。关系被分配相同的排名，跳过下一个排名。因此，如果您有 3 个项目处于第 2 位，则列出的下一个排名将是第 5 位。

DENSE_RANK()再次为您提供有序分区内的排名，但排名是连续的。如果有多个项目的行列，则不会跳过任何行列。