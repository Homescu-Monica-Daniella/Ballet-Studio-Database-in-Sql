Use BalletShow
go

SET TRANSACTION ISOLATION LEVEL SNAPSHOT
BEGIN TRAN
Select * from Guests where GuestID=15
-- Ana Voicu T2 - mihaiion@yahoo.com - 0736185942 - the value from the beginning of the transaction
Waitfor delay '00:00:10'
select * from Guests where GuestID=16
-- the value from the beginning of the transaction – Maria Voiculescu
Update Guests set Name='Maria Mal' where GuestID=15
-- process will block
-- Process will receive Error 3960.
COMMIT TRAN
