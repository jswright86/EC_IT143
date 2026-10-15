
--How do you keep track of who last modified a record?
--How do you set the "last modified by" to "server user"?

--Wiil still need the previous trigger as well.
--Will likely need to tie a trigger to a logon. (logon Trigger)

--https://learn.microsoft.com/en-us/sql/t-sql/statements/create-trigger-transact-sql?view=sql-server-ver16
--Example code to create a trigger logon

/*USE master;
GO

CREATE LOGIN login_test
    WITH PASSWORD = '<password>' MUST_CHANGE, CHECK_EXPIRATION = ON;
GO

GRANT VIEW SERVER STATE TO login_test;
GO

CREATE TRIGGER connection_limit_trigger
    ON ALL SERVER
    WITH EXECUTE AS 'login_test'
    FOR LOGON
    AS BEGIN
           IF ORIGINAL_LOGIN() = 'login_test'
              AND (SELECT COUNT(*)
                   FROM sys.dm_exec_sessions
                   WHERE is_user_process = 1
                         AND original_login_name = 'login_test') > 3
               ROLLBACK;
       END