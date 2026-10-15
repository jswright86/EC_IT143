use EC_IT143_DA;
go

INSERT INTO dbo.people(people_id, first_name, last_name, last_modified)
VALUES (5, 'Jake', 'Johnson', DEFAULT);

SELECT * FROM dbo.people_audit;