# Player Selection Rules
A number of teams need to select their players. The rules for player selection are as follows:

A player is eligible to play on a team if the first letters of the team and the player's name match.
Each team is assigned an avg_age, which represents the maximum allowed average age of players on the team.
Players are selected while the average age of the players is less than or equal to the team's avg_age.
Tables
The data is stored in two tables:

## Teams table with columns
tname: The name of the team.
avg_age: The maximum allowed average age of players on the team.
## Players table with columns
p_id: Player ID.
pname: Player name.
age: Age of the player.
## Explanation
Let's take an example to understand the player selection process:

### Team: Overachievers

They select from 15 players whose names start with 'O'.
The age threshold set for the team is 40.
Candidate Number: 1 2 3 4 5 6 7 8 9 18 11 12 13 14 15
Candidate Age: 34 39 39 39 48 43 46 47 49 50 51 51 52 52 53
Running Average Age: 34 36 37 38 38 39 40 41 42 43 43 44 45 45 49

### Team: Kicking Assets

They also follow the same logic as 'Overachievers.'
The selection process is based on the players whose names start with 'K.'
Team: The Scorekeepers

There are 43 players whose names start with 'T.'
The maximum average age that 'The Scorekeepers' team can have is 31.
However, the youngest of the 43 players is 35 years old, which is above the threshold.

Consequently, 'The Scorekeepers' team cannot select any team members and is excluded from the report.

# SOLUTION
```
-- Calculate the running average age for each player
WITH CTE_RunningAverage AS (
  SELECT p_id, pname, age, AVG(age) OVER (ORDER BY p_id ROWS UNBOUNDED PRECEDING) AS running_avg
  FROM Players
)

-- Select teams and the number of players in ascending order of team name
SELECT t.tname AS team_name, COUNT(*) AS player_count
FROM Teams t
JOIN CTE_RunningAverage r ON LEFT(t.tname, 1) = LEFT(r.pname, 1)
WHERE r.running_avg <= t.avg_age
GROUP BY t.tname
ORDER BY t.tname ASC;
```
