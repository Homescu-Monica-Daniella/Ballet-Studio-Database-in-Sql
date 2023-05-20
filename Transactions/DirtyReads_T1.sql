USE BalletShow
GO

-- T1: 1 update + delay + rollback

BEGIN TRANSACTION
UPDATE Guests 
SET Name='Maria Popescu'
WHERE GuestID=15           -- schimbat GuestID !!
WAITFOR DELAY '00:00:10'
ROLLBACK TRANSACTION

-- DELETE FROM Guests
-- DELETE FROM Schedules
-- INSERT INTO Guests VALUES ('Mihai Ionescu', 'mihaiion@yahoo.com', '0736185942')
-- SELECT * FROM Guests
-- SELECT * FROM Schedules
