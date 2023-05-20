USE BalletShow
GO

-- T2: select + delay + select
--  see the inserted value only at the second select from T2, T1 finish first
-- the result will contain the previous row version; the same number of rows (before the finish of the transaction – for example, 5 not 6)

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
BEGIN TRAN
SELECT * FROM Guests
WAITFOR DELAY '00:00:05'
SELECT * FROM Guests
COMMIT TRAN
