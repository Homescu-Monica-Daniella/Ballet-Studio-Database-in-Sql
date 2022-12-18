use BalletStudio
go

create or alter procedure addShowrooms
@n int
as
begin
	declare @i int=0
	while @i<@n
	begin
		insert into Showrooms values (-100 * @i)
		set @i=@i+1
	end
end
go

create or alter procedure deleteShowrooms
as
begin
	delete from Showrooms where Capacity<=0
end
go

create or alter procedure addSchedules
@n int
as
begin
	declare @showroomID int=(select top 1 S.ShowroomID from Showrooms S where S.Capacity<0)
	declare @i int=0
	while @i<@n
	begin
		insert into Schedules values (1, @showroomID, 1, '27/10/2022', '12:00', -1 * @i)
		set @i=@i+1
	end
end
go

create or alter procedure deleteSchedules
as
begin
	delete from Schedules where Price<=0
end
go

create or alter procedure addTickets
@n int
as
begin
declare @GuestID int
declare @ScheduleID int
declare curs cursor
	for
	select G.GuestID, S.ScheduleID from Guests G cross join (select ScheduleID from Schedules where Price<0) S
open curs
declare @i int=0
while @i<@n
begin
	fetch next from curs into @GuestID, @ScheduleID
	insert into Tickets(GuestID, ScheduleID, Quantity, Zone) values (@GuestID, @ScheduleID, -100 * @i, 'Balcony')
	set @i=@i+1
end
close curs
deallocate curs
end
go

create or alter procedure deleteTickets
as
begin
	delete from Tickets where Quantity<=0
end
go

create or alter view vShowrooms
as
	select ShowroomID from Showrooms
go

create or alter view vSchedulesAndShowrooms
as
	select S.ScheduleID, S.ShowroomID from Schedules S inner join Showrooms SR on S.ShowroomID = SR.ShowroomID
go

create or alter view vSchedulesAndTickets
as
	select S.ScheduleID, sum(T.Quantity) as Q
	from Tickets T inner join Schedules S on T.ScheduleID = S.ScheduleID
	group by S.ScheduleID, T.Quantity
go

create or alter procedure selectView
(@name varchar(100))
as
begin
	declare @sql varchar(250) = 'select * from ' + @name
	exec(@sql)
end
go

insert into Tests(Name) values ('addShowrooms'), ('deleteShowrooms'), ('addSchedules'), ('deleteSchedules'), ('addTickets'), ('deleteTickets'),  ('selectView')
insert into Tables(Name) values ('Showrooms'), ('Schedules'), ('Tickets')
insert into Views(name) values ('vShowrooms'), ('vSchedulesAndShowrooms'), ('vSchedulesAndTickets')

select * from Tests
select * from Tables
select * from Views

insert into TestViews(TestID, ViewID) values (7, 1), (7, 2), (7, 3)
insert into TestTables(TestID, TableID, NoOfRows, Position) values
(2, 1, 70, 3), (4, 2, 30, 2), (6, 3, 80, 1),
(1, 1, 30, 1), (3, 2, 50, 2), (5, 3, 20, 3)

select * from TestViews
select * from TestTables

create or alter procedure runAll
as
begin
	
	declare @name varchar(100)
	declare @tableID int
	declare @noOfRows int
	declare @viewID int
	declare @t0 datetime
	declare @t1 datetime
	declare @t2 datetime
	declare @testRunID int
	declare @description varchar(100)

	insert into TestRuns values ('', '', '')
	set @testRunID = (select max(TestRunID) from TestRuns)
	set @description = 'test' + convert(varchar, @testRunID)
	set @t0 = GETDATE()

	declare deleteCursor cursor for 
	select T.Name, TT.TableID, TT.NoOfRows
	from Tests T inner join TestTables TT on T.TestID = TT.TestID
	where T.Name like 'delete%' order by TT.Position
	open deleteCursor
	fetch deleteCursor
	into @name, @tableID, @noOfRows
	while @@FETCH_STATUS = 0
	begin
		exec @name
		fetch deleteCursor
		into @name, @tableID, @noOfRows
	end
	close deleteCursor
	deallocate deleteCursor

	declare insertCursor cursor for 
	select T.Name, TT.TableID, TT.NoOfRows
	from Tests T inner join TestTables TT on T.TestID = TT.TestID
	where T.Name like 'add%' order by TT.Position
	open insertCursor
	fetch insertCursor
	into @name, @tableID, @noOfRows
	while @@FETCH_STATUS = 0
	begin
		set @t1 = GETDATE()
		exec @name @noOfRows
		set @t2 = GETDATE()
		insert into TestRunTables values (@testRunID, @tableID, @t1, @t2)
		fetch insertCursor
		into @name, @tableID, @noOfRows
	end
	close insertCursor
	deallocate insertCursor

	declare viewCursor cursor for
	select V.Name, TV.ViewID
	from Views V inner join TestViews TV on V.ViewID = TV.ViewID
	open viewCursor
	fetch viewCursor
	into @name, @viewID
	while @@FETCH_STATUS = 0
	begin
		set @t1 = GETDATE()
		exec selectView @name
		set @t2 = GETDATE()
		insert into TestRunViews values (@testRunID, @viewID, @t1, @t2)
		fetch viewCursor
		into @name, @viewID
	end
	close viewCursor
	deallocate viewCursor

	update TestRuns
	set Description = @description, StartAt = @t0, EndAt = @t2
	where TestRunID = @testRunID

end
go

exec runAll

select * from TestRunTables
select * from TestRunViews
select * from TestRuns 