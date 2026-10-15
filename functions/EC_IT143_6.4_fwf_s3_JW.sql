--What is first name from the contact name?

-- Ask the server. Answer is in the CustomerName column, the first word followed by a space.
-- I used W3 schools to help figure out the answer. I found the string functions CHARINDEX and LEFT were the 2 necessary functions, then realized
-- that were values that had a space before the name which would throw off results. Added the LTRIM() function trim the beginning of the value
-- to pull the correct data. 
--https://www.w3schools.com/sql/func_mysql_ltrim.asp

SELECT 
    LEFT(LTRIM(CustomerName), CHARINDEX(' ', LTRIM(CustomerName), 1) - 1) AS FirstName 
FROM t_w3_schools_customers
WHERE CHARINDEX(' ', LTRIM(CustomerName), 1) > 0;
