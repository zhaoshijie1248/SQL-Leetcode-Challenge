/*
Table: Activity

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
(player_id, event_date) is the primary key of this table.
This table shows the activity of players of some games.
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on someday using some device.
 

Write an SQL query to report the device that is first logged in for each player.

Return the result table in any order.

The query result format is in the following example.

 
*/

/*solution*/
select player_id,device_id
from
(select player_id,device_id, rank() over(
    partition by player_id
    order by event_date
) as rnk
from Activity)a
where a.rnk =1

/*summary:
1. how to use window function
*/