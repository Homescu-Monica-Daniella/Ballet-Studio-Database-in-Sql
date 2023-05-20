USE BalletShow
GO

-- T2: select + delay + select
-- see the insert in first select of T2 + update in the second select of T2, T1 finish first

SET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRAN
SELECT * FROM Guests
WAITFOR DELAY '00:00:05'
SELECT * FROM Guests
COMMIT TRAN

