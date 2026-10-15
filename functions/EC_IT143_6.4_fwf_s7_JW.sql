WITH TestFirstName AS (
	SELECT dbo.get_first_name(CustomerName) AS FirstName

	FROM t_w3_schools_customers
	WHERE CHARINDEX(' ', LTRIM(CustomerName), 1) > 50
	)
SELECT FirstName

FROM TestFirstName;