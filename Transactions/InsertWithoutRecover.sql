USE BalletShow
GO

-- validation functions

CREATE OR ALTER FUNCTION ValidateName (@name varchar(50)) RETURNS INT AS
BEGIN
	DECLARE @return INT
	SET @return = 0
	IF @name <> ''
		SET @return = 1
	RETURN @return
END
GO

CREATE OR ALTER FUNCTION ValidateEmail (@email varchar(50)) RETURNS INT AS
BEGIN
	DECLARE @return INT
	SET @return = 0
	IF @email <> '' AND @email LIKE '%_@__%.__%'
		SET @return = 1
	RETURN @return
END
GO

CREATE OR ALTER FUNCTION ValidatePhone (@phone varchar(50)) RETURNS INT AS
BEGIN
	DECLARE @return INT
	SET @return = 0
	IF @phone <> '' AND @phone LIKE '07[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
		SET @return = 1
	RETURN @return
END
GO

CREATE OR ALTER FUNCTION ValidateDate (@date varchar(50)) RETURNS INT AS
BEGIN
	DECLARE @return INT
	SET @return = 0
	IF @date <> '' AND @date LIKE '[1-2][0-9][0-9][0-9]/[0-1][0-9]/[0-3][0-9]'
		SET @return = 1
	RETURN @return
END
GO

CREATE OR ALTER FUNCTION ValidateCity (@city varchar(50)) RETURNS INT AS
BEGIN
	DECLARE @return INT
	SET @return = 0
	IF @city <> ''
		SET @return = 1
	RETURN @return
END
GO

CREATE OR ALTER FUNCTION ValidatePrice (@price int) RETURNS INT AS
BEGIN
	DECLARE @return INT
	SET @return = 0
	IF @price > 0
		SET @return = 1
	RETURN @return
END
GO

CREATE OR ALTER FUNCTION ValidateQuantity (@quantity int) RETURNS INT AS
BEGIN
	DECLARE @return INT
	SET @return = 0
	IF @quantity > 0
		SET @return = 1
	RETURN @return
END
GO

CREATE OR ALTER FUNCTION ValidateZone (@zone varchar(50)) RETURNS INT AS
BEGIN
	DECLARE @return INT
	SET @return = 0
	IF @zone IN ('Balcony', 'Orchestra', 'Mezzanine')
		SET @return = 1
	RETURN @return
END
GO

-- logging system

DROP TABLE IF EXISTS LogTable 
CREATE TABLE LogTable(
Lid INT IDENTITY PRIMARY KEY,
TypeOperation VARCHAR(50),
TableOperation VARCHAR(50),
ExecutionDate DATETIME)
GO

-- insert procedure

CREATE OR ALTER PROCEDURE InsertAll (@name varchar(50), @email varchar(50), @phone varchar(50), @date varchar(50), @city varchar(50), @price int, @quantity int, @zone varchar(50)) AS
BEGIN
	BEGIN TRAN
	BEGIN TRY
		-- insert guest
		IF(dbo.ValidateName(@name) <> 1)
		BEGIN
			RAISERROR('Name should not be null!', 14, 1)
		END
		IF(dbo.ValidateEmail(@email) <> 1)
		BEGIN
			RAISERROR('Email should have a valid form!', 14, 1)
		END
		IF(dbo.ValidatePhone(@phone) <> 1)
		BEGIN
			RAISERROR('Phone should have a valid form!', 14, 1)
		END
		INSERT INTO Guests VALUES (@name, @email, @phone)
		INSERT INTO LogTable VALUES ('Insert', 'Guest', GETDATE())
		-- insert schedule
		IF(dbo.ValidateDate(@date) <> 1)
		BEGIN
			RAISERROR('Date should have a valid form!', 14, 1)
		END
		IF(dbo.ValidateCity(@city) <> 1)
		BEGIN
			RAISERROR('City should not be empty!', 14, 1)
		END
		IF(dbo.ValidatePrice(@price) <> 1)
		BEGIN
			RAISERROR('Price should be above 0!', 14, 1)
		END
		INSERT INTO Schedules VALUES (@date, @city, @price)
		INSERT INTO LogTable VALUES ('Insert', 'Schedule', GETDATE())
		-- insert ticket
		IF(dbo.ValidateQuantity(@quantity) <> 1)
		BEGIN
			RAISERROR('Quantity should be above 0!', 14, 1)
		END
		IF(dbo.ValidateZone(@zone) <> 1)
		BEGIN
			RAISERROR('Zone should be Balcony, Orchestra or Mezzanine!', 14, 1)
		END
		DECLARE @guestID INT
		SELECT @guestID = MaxGuestID FROM (SELECT MAX(GuestID) AS MaxGuestID FROM Guests) g
		DECLARE @scheduleID INT
		SELECT @scheduleID = MaxScheduleID FROM (SELECT MAX(ScheduleID) AS MaxScheduleID FROM Schedules) s
		INSERT INTO Tickets VALUES (@guestID, @scheduleID, @quantity, @zone)
		INSERT INTO LogTable VALUES ('Insert', 'Ticket', GETDATE())
		COMMIT TRAN
		SELECT 'Transaction commited'
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
		SELECT 'Transaction rollbacked'
		SELECT ERROR_NUMBER() AS ErrorNumber, ERROR_MESSAGE() AS ErrorMessage
	END CATCH
END
GO

-- commit scenario

SELECT * FROM Guests
SELECT * FROM Schedules
SELECT * FROM Tickets
SELECT * FROM LogTable
EXEC InsertAll 'Ion Popescu', 'ionpopescu@gmail.com', '0747194031', '2023/10/12', 'Cluj', 35, 3, 'Balcony'
SELECT * FROM Guests
SELECT * FROM Schedules
SELECT * FROM Tickets
SELECT * FROM LogTable

-- rollback scenario

SELECT * FROM Guests
SELECT * FROM Schedules
SELECT * FROM Tickets
SELECT * FROM LogTable
EXEC InsertAll 'Ion Popescu', 'ionpopescu@gmailcom', '0747194031', '2023/10/12', 'Cluj', 35, 3, 'Balcony'
SELECT * FROM Guests
SELECT * FROM Schedules
SELECT * FROM Tickets
SELECT * FROM LogTable

-- clear tables

DELETE FROM Tickets
DELETE FROM Guests
DELETE FROM Schedules
DELETE FROM LogTable
