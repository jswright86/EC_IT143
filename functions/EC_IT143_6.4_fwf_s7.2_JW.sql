USE EC_IT143_DA;
GO

WITH TestLastName AS(
	SELECT dbo.get_last_name(CustomerName) AS LastName
	
	FROM t_w3_schools_customers
	WHERE LEN(CustomerName) = 0
	)
	SELECT LastName
	FROM TestLastName;