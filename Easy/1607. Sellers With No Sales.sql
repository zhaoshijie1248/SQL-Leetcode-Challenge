/*
Table: Customer

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| customer_id   | int     |
| customer_name | varchar |
+---------------+---------+
customer_id is the primary key for this table.
Each row of this table contains the information of each customer in the WebStore.
 

Table: Orders

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| order_id      | int     |
| sale_date     | date    |
| order_cost    | int     |
| customer_id   | int     |
| seller_id     | int     |
+---------------+---------+
order_id is the primary key for this table.
Each row of this table contains all orders made in the webstore.
sale_date is the date when the transaction was made between the customer (customer_id) and the seller (seller_id).
 

Table: Seller

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| seller_id     | int     |
| seller_name   | varchar |
+---------------+---------+
seller_id is the primary key for this table.
Each row of this table contains the information of each seller.
 

Write an SQL query to report the names of all sellers who did not make any sales in 2020.

Return the result table ordered by seller_name in ascending order.

The query result format is in the following example.

 

Example 1:

Input: 
Customer table:
+--------------+---------------+
| customer_id  | customer_name |
+--------------+---------------+
| 101          | Alice         |
| 102          | Bob           |
| 103          | Charlie       |
+--------------+---------------+
Orders table:
+-------------+------------+--------------+-------------+-------------+
| order_id    | sale_date  | order_cost   | customer_id | seller_id   |
+-------------+------------+--------------+-------------+-------------+
| 1           | 2020-03-01 | 1500         | 101         | 1           |
| 2           | 2020-05-25 | 2400         | 102         | 2           |
| 3           | 2019-05-25 | 800          | 101         | 3           |
| 4           | 2020-09-13 | 1000         | 103         | 2           |
| 5           | 2019-02-11 | 700          | 101         | 2           |
+-------------+------------+--------------+-------------+-------------+
Seller table:
+-------------+-------------+
| seller_id   | seller_name |
+-------------+-------------+
| 1           | Daniel      |
| 2           | Elizabeth   |
| 3           | Frank       |
+-------------+-------------+
Output: 
+-------------+
| seller_name |
+-------------+
| Frank       |
+-------------+
Explanation: 
Daniel made 1 sale in March 2020.
Elizabeth made 2 sales in 2020 and 1 sale in 2019.
Frank made 1 sale in 2019 but no sales in 2020.
*/

/*solution*/
select S.seller_name
from Seller s left join Orders o
on o.seller_id=s.seller_id  AND YEAR(sale_date) = '2020'
where O.seller_id IS NULL
order by seller_name asc

/*summary:
1. SQL Joins Using WHERE or ON:
https://mode.com/sql-tutorial/sql-joins-where-vs-on/ 
2. filter year=2020:
  1. YEAR(sale_date) = '2020'
  2. date_format(sale_date, '%Y') = '2020'
3.  o.seller_id IS NULL 不是‘=NULL’
4. important mistake:

select s.seller_name
from Seller s left join Orders o
on o.seller_id=s.seller_id  
where O.seller_id IS NULL
AND YEAR(sale_date) = '2020'
order by seller_name asc

ignore the case that seller sells in other years and no 2020,
so year=2020 should be put in on clause!!!
frank still there and o.seller_id = null

eg:
select *
from Seller s left join Orders o
on o.seller_id=s.seller_id  AND YEAR(sale_date) = '2020'
#where O.seller_id IS NULL
order by seller_name asc

result:
| seller_id | seller_name | order_id | sale_date  | order_cost | customer_id | seller_id |
| --------- | ----------- | -------- | ---------- | ---------- | ----------- | --------- |
| 1         | Daniel      | 1        | 2020-03-01 | 1500       | 101         | 1         |
| 2         | Elizabeth   | 4        | 2020-09-13 | 1000       | 103         | 2         |
| 2         | Elizabeth   | 2        | 2020-05-25 | 2400       | 102         | 2         |
| 3         | Frank       |          |            |            |             |           |
*/