ALTER DATABASE BalletShow SET ALLOW_SNAPSHOT_ISOLATION ON       -- OFF

use BalletShow
go

waitfor delay '00:00:10'
BEGIN TRAN
UPDATE Guests 
SET Name ='Mircea P' 
WHERE GuestID=15           -- schimbat GuestID !!
-- Name is now Mircea Petrescu
waitfor delay '00:00:10'
COMMIT TRAN

-- SELECT * FROM Guests
