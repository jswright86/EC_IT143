/*****************************************************************************************************************
NAME:    IT 143 5.2 Final Project: My Communities Analysis - DisneyMovies Database Questions and Anwsers
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


--Q1) Which Disney movies have an IMDb rating of 8.0 or higher, and what attribute values are associated with those movies? (Folasade Adenike Adeyeye)
--A)

USE DisneyMovies;
GO

SELECT m.title as Title,
       m.imdb_rating as IMDB_Rating,
       ma.attribute_value as Attribute

FROM Movies m
INNER JOIN Movie_Attributes ma
ON m.movie_id = ma.movie_id
WHERE m.imdb_rating >= 8.0
ORDER BY m.imdb_rating DESC;

--Q2) We are looking to see which production companies bring in the highest numbers constistantly so that we can invest more into making those types of movies and less on lower profit companies. Can you make list of all the production companies and the ROI percentage for each in the last 10 years? (Joshua Wright)
--A) ROI % Formula = (Net Gain / Cost of Investment) * 100 | NET ROI % =((NG - COI) / COI) * 100)
SELECT c.company_name AS ProductionCompany,
       ROUND(
           (SUM(CAST(m.box_office_usd AS FLOAT)) - SUM(m.budget_usd)) * 100.0 / NULLIF(SUM(m.budget_usd), 0), 
           2
       ) AS Net_ROI_Percent
FROM Movie_Companies mc
INNER JOIN Companies c ON mc.company_id = c.company_id
INNER JOIN Movies m ON mc.movie_id = m.movie_id
WHERE mc.role_type LIKE 'Production%' AND release_date BETWEEN '20110101' AND '20211231'
GROUP BY c.company_name
HAVING SUM(m.budget_usd) > 0
ORDER BY Net_ROI_Percent DESC;

--Q3)We are recognizing the 10 most significant actors and actresses who have played the most roles at disney movies. They will be recongized at the Oscars this years. Can you create a list of these ten individuals showing the amount of roles they've had?(Joshua Wright)
--A

SELECT TOP (10)
    p.person_name As Actor,
    COUNT(mpr.role_type) AS NumberOfRoles    
FROM Movie_People_Roles mpr
INNER JOIN People p
    ON mpr.person_id = p.person_id
WHERE mpr.role_type = 'starring'
GROUP By
    p.person_id,
    p.person_name

ORDER BY NumberOfRoles DESC;

--Q4) We would like to see which movies had the lowest profits this year so we can move away from making those types of movies in the future. Can you create a list of the lowest ranking movies this in regards to total profit and show their profit as well as thier rotten tomatoe score?(Joshua Wright)
--A) list - 2021 movies - Total Profit(box_office_usd - budget_usd) ASC order & their RottenTomatoes Scores. There wasnt much data for 2021 and sadly quite a few NULL Values. I added 2019 and 2020, the data for these years were also largely effected by covid.

SELECT

    title AS Title,
    ((box_office_usd) - (budget_usd)) AS TotalProfit,
    rotten_tomatoes AS RottenTomatoesScore,
    LEFT(release_date,4) AS Year

FROM Movies
WHERE release_date BETWEEN '20190101' AND '20211231'
ORDER BY TotalProfit ASC;

