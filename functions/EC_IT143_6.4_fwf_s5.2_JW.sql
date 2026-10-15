USE EC_IT143_DA;
GO

DROP FUNCTION IF EXISTS dbo.get_last_name;
GO
/*****************************************************************************************************************
NAME:    dbo.get_first_name
PURPOSE: Pull last name for each customer

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     10/13/2026   JWRIGHT       1. Built this script for EC IT143 week 6.2


RUNTIME: 
Xm Xs

NOTES: 
This Script pulls the last name from the CustomerName column for each customer in the t_w3_schools_customers table. 
 
******************************************************************************************************************/

-- Q1: --What is last name from the contact name?
-- A1:--How do you extract the last name from the contact name?
--How can I get just the last name?
--Will need to use CHARINDEX and a RIGHT and TRIM function. 

-- Ask the server. Answer is in the CustomerName column, after the first word followed by a space.
-- I used W3 schools to help figure out the answer. I found the string functions CHARINDEX and LEFT were the 2 necessary functions, then realized
-- that were values that had a space before the name which would throw off results. Added the LTRIM() function trim the beginning of the value
-- to pull the correct data. 

CREATE FUNCTION dbo.get_last_name
(
    @CustomerName VARCHAR(36)
)
RETURNS VARCHAR(36)
AS
BEGIN
    DECLARE @LastName VARCHAR(36);

    SELECT
        @LastName = RIGHT(TRIM(CustomerName), LEN(TRIM(CustomerName)) - CHARINDEX(' ', TRIM(CustomerName), 1)) 
    FROM t_w3_schools_customers
    WHERE CustomerName = @CustomerName
     

    RETURN @LastName;
END;
GO
