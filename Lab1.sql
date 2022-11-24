Create database BalletStudio
go
use BalletStudio
go

CREATE TABLE Instructors
(InstructorID INT PRIMARY KEY IDENTITY,
FirstName varchar(30),
LastName varchar(30),
Telephone varchar(20))

CREATE TABLE Showrooms
(ShowroomID INT PRIMARY KEY IDENTITY,
Capacity int)

CREATE TABLE Playlists
(PlaylistID INT PRIMARY KEY IDENTITY,
Artist varchar(50),
Source varchar(30))

CREATE TABLE Choreographys
(ChoreographyID INT PRIMARY KEY IDENTITY,
Style varchar(20),
Dificulty varchar(50))

CREATE TABLE Guests
(GuestID INT PRIMARY KEY IDENTITY,
FirstName varchar(30),
LastName varchar(30),
Telephone varchar(20))

CREATE TABLE Plays
(PlayID INT PRIMARY KEY IDENTITY,
PlaylistID INT UNIQUE FOREIGN KEY REFERENCES Playlists(PlaylistID) not null,
ChoreographyID INT UNIQUE FOREIGN KEY REFERENCES Choreographys(ChoreographyID) not null,
Title varchar(50),
Duration int)

CREATE TABLE Groups
(GroupID INT PRIMARY KEY IDENTITY,
InstructorID INT FOREIGN KEY REFERENCES Instructors(InstructorID) not null,
NumberStudents int,
ExperienceYears int)

CREATE TABLE Schedules
(ScheduleID INT PRIMARY KEY IDENTITY,
GroupID INT FOREIGN KEY REFERENCES Groups(GroupID) not null,
ShowroomID INT FOREIGN KEY REFERENCES Showrooms(ShowroomID) not null,
PlayID INT FOREIGN KEY REFERENCES Plays(PlayID) not null,
Date varchar(20),
StartHour varchar(20),
Price int)

CREATE TABLE Tickets
(GuestID INT FOREIGN KEY REFERENCES Guests(GuestID) not null,
ScheduleID INT FOREIGN KEY REFERENCES Schedules(ScheduleID) not null,
CONSTRAINT pk_Tickets PRIMARY KEY (GuestID, ScheduleID),
Quantity int,
Zone varchar(20))

CREATE TABLE Students
(GroupID INT FOREIGN KEY REFERENCES Groups(GroupID) not null,
CONSTRAINT pk_Students PRIMARY KEY (GroupId, LastName),
FirstName varchar(30),
LastName varchar(30),
Telephone varchar(20),
Age int)


--use master
--go
--drop database BalletStudio