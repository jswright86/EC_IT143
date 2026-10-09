/*****************************************************************************************************************
NAME:    IT 143 5.2 Final Project: My Communities Analysis - MLBStats2025 Database Questions and Anwsers
PURPOSE: This script provides the questions and answers for the IT143 week 5.2 assigment.

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0    10/08/2026   JWRIGHT        1. Built this script for EC IT143


RUNTIME: 
0m 1s

NOTES: 
This script provides questions and lists the answers using T-SQL code
******************************************************************************************************************/

-- Q1: Which players had the highest number of home runs during the 2025 season, and how many games did each player play?
-- A1: Adjusted to display total home runs alongside both total at-bats and games played to provide a complete picture of player performance across the season.
USE MLBStats2025;
GO

SELECT TOP (10)
    p.first + ' ' + p.last AS Player,
    b.HomeRuns,
    b.AtBats,
    b.GamesPlayed
FROM (
 
    SELECT 
        id,
        SUM(b_hr) AS HomeRuns,
        SUM(b_ab) AS AtBats,
        COUNT(DISTINCT date) AS GamesPlayed
    FROM [2025batting]
    WHERE ([date] BETWEEN '20250318' AND '20250928')
       OR [date] IS NULL
    GROUP BY id
) b
INNER JOIN (

    SELECT DISTINCT 
        id,
        first, 
        last 
    FROM [2025allplayers] 
) p ON p.id = b.id
ORDER BY 
    b.HomeRuns DESC;


--Q2)We need to know who’s jersey's we need to print most for teams and individuals. Statistically the players who lead the league in home runs sell the most jerseys. Can you provide a list of the two player that hit the most home runs for each team and a seperate list for the top 10 league leaders in home runs?
--A)
SELECT TOP (10)
 
    p.first + ' ' + p.last AS Player,
    b.HomeRuns
    
FROM (
 
    SELECT 
        id,
        SUM(b_hr) AS HomeRuns
     
    FROM [2025batting]
    WHERE ([date] BETWEEN '20250318' AND '20250928')
       OR [date] IS NULL
    GROUP BY id
) b
INNER JOIN (

    SELECT DISTINCT 
        id,
        first, 
        last 
    FROM [2025allplayers] 
) p ON p.id = b.id
ORDER BY 
    b.HomeRuns DESC;

    WITH TeamHomeRuns AS (
    SELECT 
        b.team,
        p.first + ' ' + p.last AS Player,
        SUM(CAST(b.b_hr AS INT)) AS HomeRuns,
        ROW_NUMBER() OVER (
            PARTITION BY b.team 
            ORDER BY SUM(CAST(b.b_hr AS INT)) DESC
        ) AS HR_Rank
    FROM [2025batting] b
    INNER JOIN (
        SELECT DISTINCT id, first, last 
        FROM [2025allplayers]
    ) p ON p.id = b.id
    WHERE ([date] BETWEEN '20250318' AND '20250928' OR [date] IS NULL)
      AND b.team IS NOT NULL
      AND b.team NOT IN ('ALS', 'NLS') 
    GROUP BY b.team, b.id, p.first, p.last
)
SELECT 
    team,
    HR_Rank,
    Player,
    HomeRuns
FROM TeamHomeRuns
WHERE HR_Rank <= 2
ORDER BY team ASC, HR_Rank ASC;

--Q3) We are doing a commercial in the allstar game with Jimmy Johns sub sandwiches. They're known for being super fast and want the fasted player in the league to help promote their commercial. Who are the top 5 leader the league in stolen bases? Which of those players is the most recognisable?
--A) I listed the top 10, because there are more recognisable names on that list. Knowing who is the most recognisable however would require a seperate survey to have the correct data on that part of the question.

SELECT TOP (10)
 
    p.first + ' ' + p.last AS Player,
    b.StolenBases
    
FROM (
 
    SELECT 
        id,
        SUM(b_sb) AS StolenBases
     
    FROM [2025batting]
    WHERE ([date] BETWEEN '20250318' AND '20250928')
       OR [date] IS NULL
    GROUP BY id
) b
INNER JOIN (

    SELECT DISTINCT 
        id,
        first, 
        last 
    FROM [2025allplayers] 
) p ON p.id = b.id
ORDER BY 
    b.StolenBases DESC;


--Q4) We are looking at who will likely win the cy young award this year. Can you put a list together of the top 10 pitchers in the league? 
--A) Pitchers are ranked by ERA. ERA Formula = (Earned Runs * 9) / (Innings Pitched)

SELECT TOP (10)
    ap.first + ' ' + ap.last AS Player,
    b.StrikeOuts,
    b.Walks,
    b.Hits,
    b.ERA,
    b.Wins,
    b.Losses
FROM (
    SELECT 
        id,
        SUM(p_k) AS StrikeOuts,
        SUM(p_w) AS Walks,
        SUM(p_h) AS Hits,
        SUM(CAST(win AS INT)) AS Wins,
        SUM(CAST(loss AS INT)) AS Losses,
        CASE 
            WHEN SUM(p_ipouts) > 0 
            THEN ROUND((SUM(p_er) * 9.0) / (SUM(p_ipouts) / 3.0), 2)
            ELSE 0 
        END AS ERA
    FROM [2025pitching] p
    WHERE [date] BETWEEN '20250318' AND '20250928'
       OR [date] IS NULL
    GROUP BY id
    -- Requires at least 162 total innings pitched or 1 inning per regular season game(486 outs) to qualify and be considered.
    HAVING SUM(p_ipouts) >= 486 
) b
INNER JOIN (
    SELECT DISTINCT 
        id,
        first, 
        last 
    FROM [2025allplayers]
) ap ON ap.id = b.id
ORDER BY 
    b.ERA ASC;




