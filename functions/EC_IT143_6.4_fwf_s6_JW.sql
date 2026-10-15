USE [EC_IT143_DA]
GO

SELECT dbo.get_first_name(CustomerName)

FROM t_w3_schools_customers
WHERE CHARINDEX(' ', LTRIM(CustomerName), 1) > 0;

