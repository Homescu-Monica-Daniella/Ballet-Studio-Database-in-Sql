create database BalletLab5
go
use BalletLab5
go

drop table Plays
drop table Choreographys
drop table Playlists

create table Playlists
(PlaylistID int primary key,
PopularityRank int unique,
Duration int,
Artist varchar(50),
Source varchar(30))

create table Choreographys
(ChoreographyID int primary key,
NrDancers int,
Style varchar(20),
Dificulty varchar(50))

create table Plays
(PlayID int primary key,
PlaylistID int foreign key references Playlists(PlaylistID),
ChoreographyID int foreign key references Choreographys(ChoreographyID),
Title varchar(50),
Duration int)

create or alter procedure insertPlaylists
@n int 
as
begin
	declare @i int = 1
	while @i <= @n
	begin
		insert into Playlists values (@i, @i, @i % 99, 'Artitst ' + convert(varchar(50), @i), 'Source ' + convert(varchar(30), @i))
		set @i = @i + 1
	end
end
go

create or alter procedure insertChoreographys
@n int 
as
begin
	declare @i int = 1
	while @i <= @n
	begin
		insert into Choreographys values (@i, @i % 99, 'Style ' + convert(varchar(20), @i), 'Dificulty ' + convert(varchar(50), @i))
		set @i = @i + 1
	end
end
go

create or alter procedure insertPlays
@n int 
as
begin
declare @i int = 1
	while @i <= @n
	begin
		insert into Plays values (@i, @i, @i, 'Title ' + convert(varchar(50), @i), @i % 99)
		set @i = @i + 1
	end
end
go

exec insertPlaylists 1000
exec insertChoreographys 1000
exec insertPlays 1000

select * from Playlists
select * from Choreographys
select * from Plays



--a.

--clustered index scan
select * from Playlists order by PlaylistID

--clustered index seek
select * from Playlists where PlaylistID > 500

--nonclustered index scan
select PopularityRank from Playlists order by PopularityRank

--nonclustered index seek
select PopularityRank from Playlists where PopularityRank > 700

--key lookup
select Duration from Playlists where PopularityRank = 600



--b.

--clustered index scan
--cost: 0.0080857
select * from Choreographys where NrDancers = 25

--nonclustered index seek
--cost: 0.003293
create nonclustered index index2 on Choreographys(NrDancers) include (Style, Dificulty)
drop index index2 on Choreographys



--c.

create or alter view view1 
as
	select PL.PlaylistID, C.ChoreographyID, P.PlayID
	from Plays P
	inner join Playlists PL on PL.PlaylistID = P.PlaylistID
	inner join Choreographys C on C.ChoreographyID = P.ChoreographyID
	where C.NrDancers = 50 and PL.Duration = 50 
go

--cost: 0.0570933
select * from view1

--cost: 0.0383432
create nonclustered index index1 on Playlists(Duration)
drop index index1 on Playlists
create nonclustered index index3 on Plays(PlaylistID, ChoreographyID)
drop index index3 on Plays
