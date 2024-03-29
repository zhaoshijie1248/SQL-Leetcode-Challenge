/*
Table: Customers

+---------------------+---------+
| Column Name         | Type    |
+---------------------+---------+
| customer_id         | int     |
| customer_name       | varchar |
+---------------------+---------+
customer_id is the primary key for this table.
customer_name is the name of the customer.
 

Table: Orders

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| order_id      | int     |
| customer_id   | int     |
| product_name  | varchar |
+---------------+---------+
order_id is the primary key for this table.
customer_id is the id of the customer who bought the product "product_name".
 

Write an SQL query to report the customer_id and customer_name of customers who bought products "A", "B" but did not buy the product "C" since we want to recommend them to purchase this product.

Return the result table ordered by customer_id.

The query result format is in the following example.

 

Example 1:

Input: 
Customers table:
+-------------+---------------+
| customer_id | customer_name |
+-------------+---------------+
| 1           | Daniel        |
| 2           | Diana         |
| 3           | Elizabeth     |
| 4           | Jhon          |
+-------------+---------------+
Orders table:
+------------+--------------+---------------+
| order_id   | customer_id  | product_name  |
+------------+--------------+---------------+
| 10         |     1        |     A         |
| 20         |     1        |     B         |
| 30         |     1        |     D         |
| 40         |     1        |     C         |
| 50         |     2        |     A         |
| 60         |     3        |     A         |
| 70         |     3        |     B         |
| 80         |     3        |     D         |
| 90         |     4        |     C         |
+------------+--------------+---------------+
Output: 
+-------------+---------------+
| customer_id | customer_name |
+-------------+---------------+
| 3           | Elizabeth     |
+-------------+---------------+
Explanation: Only the customer_id with id 3 bought the product A and B but not the product C.
*/

/*solution 1*/
SELECT * 
FROM Customers c
WHERE c.customer_id IN (SELECT customer_id FROM Orders WHERE product_name = 'A')
	AND c.customer_id IN (SELECT customer_id FROM Orders WHERE product_name = 'B')
	AND c.customer_id NOT IN (SELECT customer_id FROM Orders WHERE product_name = 'C')   

/*solution 2*/
select a.customer_id, a.customer_name
from customers a , orders b
where a.customer_id  = b.customer_id
group by a.customer_id
having sum(b.product_name="A") >0 and sum(b.product_name="B") > 0 and sum(b.product_name="C")=0

/*summary:
1. 行转列
*/

第二次做：
select distinct a.customer_id, b.customer_name
from 
(select customer_id, 
sum(if(product_name='A',1,0)) as num_a, 
sum(if(product_name='B',1,0)) as num_b, 
sum(if(product_name='C',1,0)) as num_c
from Orders
group by 1)a
inner join
(select customer_id, customer_name
from Customers)b
on a.customer_id=b.customer_id
where num_a>0
and num_b>0
and num_c=0
order by customer_id

注意：
区别sum 和count
记得加group by 1