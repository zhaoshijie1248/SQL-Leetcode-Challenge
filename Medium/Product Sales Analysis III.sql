Table: Sales

+-------------+-------+
| Column Name | Type  |
+-------------+-------+
| sale_id     | int   |
| product_id  | int   |
| year        | int   |
| quantity    | int   |
| price       | int   |
+-------------+-------+
(sale_id, year) is the primary key of this table.
product_id is a foreign key to Product table.
Each row of this table shows a sale on the product product_id in a certain year.
Note that the price is per unit.
 

Table: Product

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| product_id   | int     |
| product_name | varchar |
+--------------+---------+
product_id is the primary key of this table.
Each row of this table indicates the product name of each product.
 

Write an SQL query that selects the product id, year, quantity, and price for the first year of every product sold.

Return the resulting table in any order.

The query result format is in the following example.

 


 Solution:

 1


 select a.product_id, a.first_year, b.quantity, b.price
from
(select product_id, min(year) as first_year
from Sales 
group by product_id)a
join
(select product_id, year, quantity, price
from Sales )b
on a.product_id=b.product_id and a.first_year=b.year



2

with fy as(
    select product_id, year, quantity, price, 
    dense_rank() over (partition by product_id order by year asc) as rnk
    FROM Sales
)
SELECT
     product_id,
    year AS first_year,
    quantity,
    price
FROM fy where rnk = 1


row_number:不管排名是否有相同的，都按照顺序1，2，3…..n
rank:排名相同的名次一样，同一排名有几个，后面排名就会跳过几次
dense_rank:排名相同的名次一样，且后面名次不跳跃