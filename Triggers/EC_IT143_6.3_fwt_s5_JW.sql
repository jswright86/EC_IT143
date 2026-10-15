USE EC_IT143_DA;
GO

INSERT INTO people (people_id, first_name, last_name)
VALUES (4, 'bob', 'Wright');

SELECT TOP(5)
*FROM dbo.people;

SELECT [audit_people_id]
      ,[audit_first_name]
      ,[audit_last_name]
      ,[audit_last_modified]
  FROM [dbo].[people_audit]

GO