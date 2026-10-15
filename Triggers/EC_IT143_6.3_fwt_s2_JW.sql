--How can I keep track of when a record was last modified?

--When DML was last used? (datetime) 
--Which commands can modify records?
--Create a record to keep of modifications

--DATE
--Modifying Commands
--Creat Record

/*Sample code from https://learn.microsoft.com/en-us/sql/t-sql/functions/columns-updated-transact-sql?view=sql-server-ver16
Create a table and then create an audit table to compare data between the two tables using the COLUMNS UPDATED() function
Create trigger that will execute when an update occurs and will compare the two and update the audit table.
