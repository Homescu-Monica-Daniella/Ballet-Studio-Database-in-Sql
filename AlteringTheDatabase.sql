USE BalletStudio


--a. modify the type of a column

CREATE OR ALTER PROCEDURE modifyPriceFromSchedulesFromIntToFloat
AS
BEGIN
	ALTER TABLE Schedules
	ALTER COLUMN Price FLOAT
END
GO

CREATE OR ALTER PROCEDURE modifyPriceFromSchedulesFromFloatToInt
AS
BEGIN
	ALTER TABLE Schedules
	ALTER COLUMN Price INT
END
GO


--b. add / remove a column

CREATE OR ALTER PROCEDURE addSalaryToInstructors
AS
BEGIN
	ALTER TABLE Instructors
	ADD Salary FLOAT
END
GO

CREATE OR ALTER PROCEDURE removeSalaryFromInstructors
AS
BEGIN
	ALTER TABLE Instructors
	DROP COLUMN Salary
END
GO


--c. add / remove a DEFAULT constraint

CREATE OR ALTER PROCEDURE addDFCToCapacityFromShowrooms
AS
BEGIN
	ALTER TABLE Showrooms
	ADD CONSTRAINT df_capacity
	DEFAULT 0 FOR Capacity
END
GO

CREATE OR ALTER PROCEDURE removeDFCToCapacityFromShowrooms
AS
BEGIN
	ALTER TABLE Showrooms
	DROP CONSTRAINT df_capacity
END
GO


--d. add / remove a primary key

CREATE OR ALTER PROCEDURE addPKForManagers
AS
BEGIN
	ALTER TABLE Managers
	DROP CONSTRAINT pk_Managers
	ALTER TABLE Managers
	ADD CONSTRAINT pk_Managers PRIMARY KEY(FirstName)
END
GO

CREATE OR ALTER PROCEDURE removePKFromManagers
AS
BEGIN
	ALTER TABLE Managers
	DROP CONSTRAINT pk_Managers
	ALTER TABLE Managers
	ADD CONSTRAINT pk_Managers PRIMARY KEY(ManagerID)
END
GO


--e. add / remove a candidate key

CREATE OR ALTER PROCEDURE addCKForPlaylists
AS
BEGIN
	ALTER TABLE Playlists
	ADD CONSTRAINT ck_playlist UNIQUE(Artist, Source)
END
GO

CREATE OR ALTER PROCEDURE removeCKFromPlaylists
AS
BEGIN
	ALTER TABLE Playlists
	DROP CONSTRAINT ck_playlist
END
GO


--f. add / remove a foreign key

CREATE OR ALTER PROCEDURE addFKForManagers
AS
BEGIN
	ALTER TABLE Managers
	ADD CONSTRAINT fk_Managers FOREIGN KEY(InstructorID) REFERENCES Instructors(InstructorID)
END
GO

CREATE OR ALTER PROCEDURE removeFKFromManagers
AS
BEGIN
	ALTER TABLE Managers
	DROP CONSTRAINT fk_Managers
END
GO


--g. create / drop a table

CREATE OR ALTER PROCEDURE addManagersTable
AS
BEGIN
	CREATE TABLE Managers (
		ManagerID int,
		FirstName varchar(30) NOT NULL,
		LastName varchar(30) NOT NULL,
		Telephone varchar(20) NOT NULL,
		CONSTRAINT pk_Managers PRIMARY KEY(ManagerID),
		InstructorID INT NOT NULL
	)
END
GO

CREATE OR ALTER PROCEDURE dropManagersTable
AS
BEGIN
	DROP TABLE Managers
END
GO


CREATE TABLE currentVersion (crnt_ver INT)

INSERT INTO currentVersion VALUES (0)


CREATE TABLE storedProcedures (
	from_proc INT,
	to_proc INT,
	proc_name VARCHAR(100),
	PRIMARY KEY (from_proc, to_proc))

INSERT INTO storedProcedures VALUES
(0, 1, 'modifyPriceFromSchedulesFromIntToFloat'),
(1, 0, 'modifyPriceFromSchedulesFromFloatToInt'),
(1, 2, 'addSalaryToInstructors'),
(2, 1, 'removeSalaryFromInstructors'),
(2, 3, 'addDFCToCapacityFromShowrooms'),
(3, 2, 'removeDFCToCapacityFromShowrooms'),
(3, 4, 'addManagersTable'),
(4, 3, 'dropManagersTable'),
(4, 5, 'addPKForManagers'),
(5, 4, 'removePKFromManagers'),
(5, 6, 'addCKForPlaylists'),
(6, 5, 'removeCKFromPlaylists'),
(6, 7, 'addFKForManagers'),
(7, 6, 'removeFKFromManagers')


CREATE OR ALTER PROCEDURE bringToVersion(@versionNumber INT)
AS
BEGIN

	DECLARE @crntVersion INT
	SELECT @crntVersion = crnt_ver FROM currentVersion
	DECLARE @procedureName VARCHAR(100)

	IF @versionNumber < 0 OR @versionNumber > 7
		RAISERROR ('Version number should be between 0 and 7!', 10, 1)
	ELSE
		BEGIN

			IF @crntVersion > @versionNumber
			BEGIN
				WHILE @crntVersion > @versionNumber
				BEGIN
					SELECT @procedureName = proc_name FROM storedProcedures WHERE from_proc = @crntVersion AND to_proc = @crntVersion - 1
					PRINT('Executing ' + @procedureName)
					EXEC @procedureName
					SET @crntVersion = @crntVersion - 1
				END
			END
			 
			ELSE

			BEGIN
				WHILE @crntVersion < @versionNumber
				BEGIN
					SELECT @procedureName = proc_name FROM storedProcedures WHERE from_proc = @crntVersion AND to_proc = @crntVersion + 1
					PRINT('Executing ' + @procedureName)
					EXEC @procedureName
					SET @crntVersion = @crntVersion + 1
				END
			END

			UPDATE currentVersion SET crnt_ver = @versionNumber

		END

END
GO


EXEC bringToVersion 0
SELECT * FROM currentVersion
SELECT * FROM storedProcedures
