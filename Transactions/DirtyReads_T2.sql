USE BalletShow
GO

-- T2: select + delay + select
-- we see the update in the first select (T1 – finish first), even if it is rollback then

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
BEGIN TRAN
SELECT * FROM Guests
WAITFOR DELAY '00:00:15'
SELECT * FROM Guests
COMMIT TRAN
