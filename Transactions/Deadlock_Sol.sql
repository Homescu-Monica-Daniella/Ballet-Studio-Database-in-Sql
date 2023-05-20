USE BalletShow
GO

-- Sol: SET DEADLOCK_PRIORITY TO HIGH

SET DEADLOCK_PRIORITY HIGH
begin tran
update Schedules set City='Brasov T2' where ScheduleID=11           -- schimbat ScheduleID !!
-- this transaction has exclusively lock on table Schedules
waitfor delay '00:00:10'
update Guests set Name='Ana Voicu T2' where GuestID=15           -- schimbat GuestID !!
commit tran
-- this transaction has the higher priority level from here (set to HIGH)
-- transaction 1 finish with an error, and the results are the ones from this transaction (transaction 2)

SELECT * FROM Guests
SELECT * FROM Schedules
