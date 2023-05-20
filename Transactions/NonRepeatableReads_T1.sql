USE BalletShow
GO

-- T1: insert + delay + update + commit

INSERT INTO Guests VALUES ('Maria Voiculescu', 'mariav@yahoo.com', '0746193638')
BEGIN TRAN
WAITFOR DELAY '00:00:05'
UPDATE Guests 
SET Email='mariavoiculescu@gmail.com' 
WHERE Name='Maria Voiculescu'
COMMIT TRAN
