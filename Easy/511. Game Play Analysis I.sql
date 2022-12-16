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
 

Write an SQL query to report the first login date for each player.

Return the result table in any order.

The query result format is in the following example.
*/

/*solution*/
SELECT
  X.player_id,
  X.event_date AS first_login
FROM
  (
    SELECT
      A.player_id,
      A.event_date,
      RANK() OVER (
        PARTITION BY
          A.player_id
        ORDER BY
          A.event_date
      ) AS rnk
    FROM
      Activity A
  ) X
WHERE
  X.rnk = 1;

/*summary:
1. how to use window function
*/