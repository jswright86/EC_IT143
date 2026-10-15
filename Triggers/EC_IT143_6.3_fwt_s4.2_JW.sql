USE EC_IT143_DA;
GO

DROP TRIGGER IF EXISTS dbo.updPeople;
GO
/*****************************************************************************************************************
NAME:    dbo.updPeople
PURPOSE: Creates a trigger tracking when and who updated a record.

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     10/13/2026   JWRIGHT       1. Built this script for EC IT143 week 6.2
1.1     10/14/2026   JWRIGHT       2. Added user tracking via ORIGINAL_LOGIN() for deliverable requirements.

RUNTIME: 
Xm Xs

NOTES: 
This Script creates a trigger that executes when an update, insert, or delete occurs. 
It captures both the old and new data, the timestamp, and the user identity.
******************************************************************************************************************/

CREATE TRIGGER [dbo].[updPeople]
ON [dbo].[people]
AFTER UPDATE, INSERT, DELETE 
AS 
BEGIN
    -- Release trigger if no rows were affected
    IF (ROWCOUNT_BIG() = 0)
        RETURN;

    -- Checks if Column 2, 3 and 4 was updated (2 + 4 + 8 = 14)
    IF (COLUMNS_UPDATED() & 14) > 0 
    BEGIN
        -- Audit OLD record 
        INSERT INTO dbo.people_audit(
            audit_people_id,
            audit_first_name,
            audit_last_name,
            audit_last_modified,
            audit_modified_by
        )
        SELECT 
            del.people_id,
            del.first_name,
            del.last_name,
            del.last_modified,
            ORIGINAL_LOGIN()    --Added function to return the name of the original login that established current connection when the trigger is ran. 10/14/2026
        FROM deleted as del;
        
        -- Audit NEW record 
        INSERT INTO dbo.people_audit(
            audit_people_id,
            audit_first_name,
            audit_last_name,
            audit_last_modified,
            audit_modified_by
        )
        SELECT 
            ins.people_id,
            ins.first_name,
            ins.last_name,
            ins.last_modified,
            ORIGINAL_LOGIN() -- ADDED 10/14/2026
        FROM inserted as ins;
    END
END
GO