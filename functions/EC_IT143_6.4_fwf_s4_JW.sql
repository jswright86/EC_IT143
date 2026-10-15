USE EC_IT143_DA;
GO

DROP FUNCTION IF EXISTS dbo.get_first_name;
GO
/*****************************************************************************************************************
NAME:    dbo.get_first_name
PURPOSE: Pull first name for each customer

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     10/12/2026   JWRIGHT       1. Built this script for EC IT143 week 6.2


RUNTIME: 
Xm Xs

NOTES: 
This Script pulls the first name from the CustomerName column for each customer in the t_w3_schools_customers table. 
 
******************************************************************************************************************/

-- Q1: --What is first name from the contact name?
-- A1: -- Ask the server. Answer is in the CustomerName column, the first word followed by a space.
-- I used W3 schools to help figure out the answer. I found the string functions CHARINDEX and LEFT were the 2 necessary functions, then realized
-- that were values that had a space before the name which would throw off results. Added the LTRIM() function trim the beginning of the value
-- to pull the correct data. 

CREATE FUNCTION dbo.get_first_name
(
    @CustomerName VARCHAR(36)
)
RETURNS VARCHAR(36)
AS
BEGIN
    DECLARE @FirstName VARCHAR(36);

    SELECT
        @FirstName = LEFT(LTRIM(CustomerName), CHARINDEX(' ', LTRIM(CustomerName), 1) - 1) 
    FROM t_w3_schools_customers
    WHERE CustomerName = @CustomerName
      AND CHARINDEX(' ', LTRIM(CustomerName), 1) > 0;

    RETURN @FirstName;
END;
GO
