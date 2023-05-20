USE BalletShow
GO

-- T2: update on table B + delay + update on table A

begin tran
update Schedules set City='Brasov T2' where ScheduleID=11           -- schimbat ScheduleID !!
-- this transaction has exclusively lock on table Schedules
waitfor delay '00:00:10'
update Guests set Name='Ana Voicu T2' where GuestID=15           -- schimbat GuestID !!
-- this transaction will be blocked because transaction 1 has exclusively lock on table Guests, so, both of the transactions are blocked
commit tran
-- after some seconds transaction 2 will be chosen as a deadlock victim and terminates with an error
-- in tables Guests and Schedules will be the values from transaction 1

SELECT * FROM Guests
SELECT * FROM Schedules

