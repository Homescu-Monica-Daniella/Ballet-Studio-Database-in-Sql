USE BalletShow
GO

-- T1: delay + insert + commit

BEGIN TRAN
WAITFOR DELAY '00:00:04'
INSERT INTO Guests VALUES ('Matei Stanescu', 'smatei@yahoo.com', '0738472942')
COMMIT TRAN
