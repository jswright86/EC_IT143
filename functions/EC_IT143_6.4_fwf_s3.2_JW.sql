
--How do you extract the last name from the contact name?
--How can I get just the last name?
--Will need to do the opposite of the first question with a RIGHT and TRIM function instead. Still using the CHARINDEX.
SELECT 
    RIGHT(TRIM(CustomerName), LEN(TRIM(CustomerName)) - CHARINDEX(' ', TRIM(CustomerName), 1)) AS Last
FROM t_w3_schools_customers;