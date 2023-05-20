use master
drop database BalletShow

Create database BalletShow
go
use BalletShow
go

CREATE TABLE Guests
(GuestID INT PRIMARY KEY IDENTITY,
Name varchar(50),
Email varchar(50),
Phone varchar(50))

CREATE TABLE Schedules
(ScheduleID INT PRIMARY KEY IDENTITY,
Date varchar(50),
City varchar(50),
Price int)

CREATE TABLE Tickets
(GuestID INT FOREIGN KEY REFERENCES Guests(GuestID),
ScheduleID INT FOREIGN KEY REFERENCES Schedules(ScheduleID),
CONSTRAINT pk_Tickets PRIMARY KEY (GuestID, ScheduleID))

