USE BalletShow
GO

-- Sol: SET TRANSACTION ISOLATION LEVEL TO SERIALIZABLE
-- the new inserted values are not visible at the end of T2 and T1, only if we make a new select and test it

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
BEGIN TRAN
SELECT * FROM Guests
WAITFOR DELAY '00:00:05'
SELECT * FROM Guests
COMMIT TRAN

SELECT * FROM Guests
