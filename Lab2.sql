use BalletStudio



--insert data – for at least 4 tables; at least one statement must violate referential integrity constraints

INSERT INTO Instructors (FirstName, LastName, Telephone) VALUES 
('Hillary', 'Barber', '(206) 342-8631'),
('Kallie', 'Glover', '(717) 550-1675'),
('Karina', 'Walker', '(248) 762-0356'),
('Robert', 'Yehudit', '(896) 332-6829');
SELECT * FROM Instructors

INSERT INTO Showrooms (Capacity) VALUES
(75),
(90),
(85),
(70),
(65),
(80);
SELECT * FROM Showrooms

INSERT INTO Playlists (Artist, Source) VALUES
('Igor Stravinsky', 'Spotify'),
('Nino Rota', 'Youtube'),
('Maurice Ravel', 'Apple Music'),
('Harry Partch', 'Spotify'),
('Max Richter', 'Youtube');
SELECT * FROM Playlists

INSERT INTO Choreographys (Style, Dificulty) VALUES
('classical', 'Advanced'),
('neoclassical', 'Beginner'),
('contemporary', 'Intermediate'),
('classical', 'Intermediate'),
('neoclassical', 'Advanced');
SELECT * FROM Choreographys

INSERT INTO Guests (FirstName, LastName, Telephone) VALUES
('Lillianna', 'Chandler', '(253) 644-2182'),
('Denzel', 'Kramer', '(212) 658-3916'),
('Elianna', 'Duncan', '(209) 300-2557'),
('Makayla', 'Pugh', '(262) 162-1585'),
('Colten', 'Reese', '(252) 258-3799'),
('Joselyn', 'Douglas', '(234) 109-6666'),
('Konnor', 'Bridges', '(201) 874-8593'),
('Javier', 'Tapia', '(903) 460-8700'),
('Gabriel', 'Montes', '(717) 308-9696'),
('Johan', 'Myers', '(315) 096-9157');
SELECT * FROM Guests

INSERT INTO Plays (PlaylistID, ChoreographyID, Title, Duration) VALUES
(2, 1, 'Swan Lake', 60),
(5, 3, 'Cinderella', 60),
(3, 2, 'The Nutcracker', 120),
(1, 4, 'Sleeping Beauty', 60),
(4, 5, 'Romeo and Juliet', NULL);
SELECT * FROM Plays
--INSERT INTO Plays (PlaylistID, ChoreographyID, Title, Duration) VALUES (1, 2, 'Belle', 180);

INSERT INTO Groups (InstructorID, NumberStudents, ExperienceYears) VALUES
(2, 12, 2),
(1, 10, 3),
(2, 17, 5),
(3, 20, 1),
(1, 11, 2);
SELECT * FROM Groups

INSERT INTO Schedules (GroupID, ShowroomID, PlayID, Date, StartHour, Price) VALUES
(3, 4, 5, '27/10/2022', '12:00', 25),
(5, 5, 3, '10/01/2023', '16:00', 31),
(1, 2, 1, '14/05/2023', '14:00', 20),
(1, 1, 4, '30/11/2022', '18:00', 23),
(4, 3, 3, '08/02/2023', '19:00', 26);
SELECT * FROM Schedules

INSERT INTO Tickets (GuestID, ScheduleID, Quantity, Zone) VALUES
(1, 5, 3, 'Orchestra'),
(2, 4, 1, 'Mezzanine'),
(3, 1, 5, 'Balcony'),
(4, 5, 10, 'Mezzanine'),
(5, 2, 32, 'Mezzanine'),
(6, 2, 9, 'Balcony'),
(7, 2, 1, 'Orchestra'),
(8, 5, 16, 'Orchestra'),
(9, 4, 4, 'Mezzanine'),
(10, 3, 2, 'Balcony');
SELECT * FROM Tickets

INSERT INTO Students (GroupID, FirstName, LastName, Telephone, Age) VALUES
(1, 'Mikayla', 'Shepard', '(601) 500-8632', 17),
(5, 'Kelsie', 'Valdez', '(316) 161-4662', 12),
(3, 'Brooklyn', 'Brown', '(727) 872-0698', 18),
(2, 'Kelsey', 'Sosa', '(509) 348-4394', 19),
(5, 'Jadyn', 'Benjamin', '(219) 568-6929',19),
(1, 'Tania', 'Arroyo', '(515) 157-5295', 16),
(1, 'Cloe', 'Vance', '(307) 227-9486', 16),
(5, 'Danna', 'Greene', '(602) 425-2522', 17),
(2, 'Savannah', 'Carlson', '(365) 038-8729', 13),
(3, 'Lillianna', 'Taylor', '(786) 919-2835', 17),
(3, 'Miya', 'Mathews', '(585) 145-3645', 16),
(2, 'Jazlyn', 'Lynch', '(435) 117-5105', 15),
(1, 'Natalie', 'Lambert', '(657) 817-0758', 14),
(4, 'Marilyn', 'Ayers', '(508) 127-2571', 14),
(5, 'Brooklyn', 'Duncan', '(415) 230-9946', 18);
SELECT * FROM Students



--update data – for at least 3 tables

--update number of students to increment in groups where number of students is less than 12
SELECT * FROM Groups
UPDATE Groups
SET NumberStudents=NumberStudents+1
WHERE NumberStudents<12
SELECT * FROM Groups

--update duration to 120 in plays where duration is null
SELECT * FROM Plays
UPDATE Plays
SET Duration=120
WHERE Duration IS NULL
SELECT * FROM Plays

--update quantity to 7 in tickets where id of schedule is 4 or 5 and quantity is between 1 and 3
SELECT * FROM Tickets
UPDATE Tickets
SET Quantity=7
WHERE ScheduleID IN (4, 5) AND Quantity BETWEEN 1 AND 3
SELECT * FROM Tickets



--delete data – for at least 2 tables

--delete showrooms where capacity is not less than 100
INSERT INTO Showrooms (Capacity) VALUES (110);
SELECT * FROM Showrooms
DELETE FROM Showrooms
WHERE NOT Capacity<100
SELECT * FROM Showrooms

--delete choreographys where style includes the word 'modern' or dificulty is 'hard'
INSERT INTO Choreographys (Style, Dificulty) VALUES ('very modern style', 'hard');
SELECT * FROM Choreographys
DELETE FROM Choreographys
WHERE Style LIKE '%modern%' OR Dificulty='hard'
SELECT * FROM Choreographys



--a. 2 queries with the union operation; use UNION [ALL] and OR

--get last name of instructors and students that have first name starting with 'K', ordered in descending order by last name

SELECT I.LastName
FROM Instructors I
WHERE I.FirstName LIKE 'K%'
UNION
SELECT S.LastName
FROM Students S
WHERE S.FirstName LIKE 'K%'
ORDER BY I.LastName DESC

--get distinct title of plays where artist is Igor Stravinsky or style is neoclassical

SELECT DISTINCT P.Title
FROM Plays P, Playlists PL, Choreographys C
WHERE (P.PlaylistID=PL.PlaylistID AND PL.Artist='Igor Stravinsky') OR (P.ChoreographyID=C.ChoreographyID AND C.Style='neoclassical')



--b. 2 queries with the intersection operation; use INTERSECT and IN

--get first names that are found in both students and guests

SELECT S.FirstName
FROM Students S
INTERSECT
SELECT G.FirstName
FROM Guests G

--get from students last names that are also found in guests

SELECT S.LastName
FROM Students S
WHERE S.LastName IN (SELECT G.LastName FROM Guests G)



--c. 2 queries with the difference operation; use EXCEPT and NOT IN

--get first names that are not found in both students and guests

SELECT S.FirstName
FROM Students S
EXCEPT
SELECT G.FirstName
FROM Guests G

--get from students last names that are not found in guests

SELECT S.LastName
FROM Students S
WHERE S.LastName NOT IN (SELECT G.LastName FROM Guests G)



--d. 4 queries with INNER JOIN, LEFT JOIN, RIGHT JOIN, and FULL JOIN (one query per operator); one query will join at least 3 tables, while another one will join at least two many-to-many relationships

--get for each group what instructor and students it has

SELECT G.GroupID, I.FirstName, I.LastName, S.FirstName, S.LastName
FROM Groups G
INNER JOIN Instructors I ON G.InstructorID=I.InstructorID
INNER JOIN Students S ON G.GroupID=S.GroupID

-- get play titles and any schedules they might have

SELECT P.Title, S.ScheduleID
FROM Schedules S
RIGHT JOIN Plays P ON S.PlayID=P.PlayID

--get instructors and any groups they might have

SELECT I.FirstName, I.LastName, G.GroupID
FROM Instructors I
LEFT JOIN Groups G ON I.InstructorID=G.InstructorID


--get id of schedules, title of plays, capacity of showrooms and last name of guests, even if a play or a showroom is not scheduled yet

SELECT S.ScheduleID, P.Title, SR.Capacity, G.LastName
FROM Schedules S
FULL JOIN Tickets T ON S.ScheduleID=T.ScheduleID
FULL JOIN Guests G ON T.GuestID=G.GuestID
FULL JOIN Showrooms SR ON S.ShowroomID=SR.ShowroomID
FULL JOIN Plays P ON S.PlayID=P.PlayID



--e. 2 queries with the IN operator and a subquery in the WHERE clause; in at least one case, the subquery must include a subquery in its own WHERE clause

--get first and last name of guests that bought an even number of tickets

SELECT G.FirstName, G.LastName
FROM Guests G
WHERE G.GuestID IN 
(SELECT T.GuestID
FROM Tickets T
WHERE T.Quantity%2=0)

--get distinct ids of scheduled plays that have choreogrpahy style that is neoclassical

SELECT DISTINCT S.PlayID
FROM Schedules S
WHERE S.PlayID IN
(SELECT P.PlayID
FROM Plays P
WHERE P.ChoreographyID IN
(SELECT C.ChoreographyID
FROM Choreographys C
WHERE C.Style='neoclassical'))



--f. 2 queries with the EXISTS operator and a subquery in the WHERE clause

--get id of only showrooms that appear in a schedule

SELECT SR.ShowroomID
FROM Showrooms SR
WHERE EXISTS
(SELECT *
FROM Schedules S
WHERE S.ShowroomID=SR.ShowroomID)

--get id of only groups that have at least one student younger than 13

SELECT G.GroupID
FROM Groups G
WHERE EXISTS
(SELECT *
FROM Students S
WHERE S.GroupID=G.GroupID AND S.Age+1<14)



--g. 2 queries with a subquery in the FROM clause

--get from students with age over 18 the distinct first names of the ones that do not have last name ending in 'a'

SELECT DISTINCT T.FirstName
FROM (SELECT * FROM Students S WHERE S.Age>=18) AS T 
WHERE NOT T.LastName LIKE '%a'

--get top id of schedule with date in 2023 that has price greater than 25

SELECT TOP 1 H.ScheduleID
FROM (SELECT * FROM Schedules S WHERE S.Date LIKE '%/2023') AS H
WHERE H.Price>25



--h. 4 queries with the GROUP BY clause, 3 of which also contain the HAVING clause; 2 of the latter will also have a subquery in the HAVING clause; use the aggregation operators: COUNT, SUM, AVG, MIN, MAX

--get each choreograhy style and the number of choreographys that use it

SELECT C.Style, COUNT(*) AS Times_used
FROM Choreographys C
GROUP BY C.Style

--get average age of groups that have more than one student

SELECT GroupID, AVG(Age) AS Avg_age
FROM Students 
GROUP BY GroupID
HAVING COUNT(GroupID)>1

--get students that have age greater than the average age of all students

SELECT S.FirstName, S.LastName, S.Age
FROM Students S
GROUP BY S.FirstName, S.LastName, S.Age
HAVING S.Age >
(SELECT AVG(S.Age) AS Avg_age
FROM Students S)

--get the choreography style that has the most minutes being used in all plays

SELECT C.Style, SUM(P.Duration) AS Max_minutes
FROM Choreographys C INNER JOIN Plays P ON C.ChoreographyID=P.ChoreographyID
GROUP BY C.Style
HAVING SUM(P.Duration) = 
(SELECT MAX(M.Total)
FROM (SELECT SUM(P.Duration) AS Total
FROM Plays P INNER JOIN Choreographys C ON P.ChoreographyID=C.ChoreographyID
GROUP BY C.Style) M)



--i. 4 queries using ANY and ALL to introduce a subquery in the WHERE clause (2 queries per operator); rewrite 2 of them with aggregation operators, and the other 2 with IN / [NOT] IN

--get tickets that have quantity greater than any quantity of a ticket in zone 'Mezzanine'

SELECT T.GuestID, T.Quantity, T.Zone
FROM Tickets T
WHERE T.Quantity > ANY
(SELECT K.Quantity
FROM Tickets K
WHERE K.Zone='Mezzanine')

SELECT T.GuestID, T.Quantity, T.Zone
FROM Tickets T
WHERE T.Quantity > ANY
(SELECT MAX(K.Quantity)
FROM Tickets K
WHERE K.Zone='Mezzanine')

--get first and last name of students that have 2 years experience

SELECT S.FirstName, S.LastName
FROM Students S
WHERE S.GroupID = ANY
(SELECT G.GroupID
FROM Groups G
WHERE G.ExperienceYears=2)

SELECT S.FirstName, S.LastName
FROM Students S
WHERE S.GroupID IN
(SELECT G.GroupID
FROM Groups G
WHERE G.ExperienceYears=2)

--get top 3 showrooms that have capacity smaller than the greatest capacity, ordered in ascending order by capacity

SELECT TOP 3 S.ShowroomID, S.Capacity
FROM Showrooms S
WHERE S.Capacity < ALL
(SELECT R.Capacity
FROM Showrooms R
WHERE R.Capacity>85)
ORDER BY S.Capacity

SELECT TOP 3 S.ShowroomID, Capacity
FROM Showrooms S
WHERE S.Capacity < ALL
(SELECT MAX(R.Capacity)
FROM Showrooms R)
ORDER BY S.Capacity

--get plays that do not have duration greater than 60

SELECT P.PlayID, P.Duration
FROM Plays P
WHERE P.PlayID <> ALL
(SELECT L.PlayID
FROM Plays L
WHERE L.Duration*2>120)

SELECT P.PlayID, P.Duration
FROM Plays P
WHERE P.PlayID NOT IN
(SELECT L.PlayID
FROM Plays L
WHERE L.Duration>60)
