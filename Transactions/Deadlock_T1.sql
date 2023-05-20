USE BalletShow
GO

-- T1: update on table A + delay + update on table B

begin tran
update Guests set Name='Ana Voicu T1' where GuestID=15           -- schimbat GuestID !!
-- this transaction has exclusively lock on table Guests
waitfor delay '00:00:10'
update Schedules set City='Brasov T1' where ScheduleID=11           -- schimbat ScheduleID !!
-- this transaction will be blocked because transaction 2 has already blocked our lock on table Schedules
commit tran

-- SELECT * FROM Guests
-- SELECT * FROM Schedules
-- INSERT INTO Schedules VALUES ('2023/10/09', 'Iasi', 40)
-- SELECT * FROM Schedules
