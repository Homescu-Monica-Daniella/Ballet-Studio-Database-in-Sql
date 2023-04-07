# Ballet-Studio-Database

<img width="100%" height="100%" src="/demos/demo1.PNG" width="80%">

## Database Design

Imagine a simple application that requires a database. Represent the application data in a relational structure and implement the structure in a SQL Server database. The database must contain at least: 10 tables, two `1:n` relationships, one `m:n` relationship.

## SQL Queries

On the relational structure created, write SQL statements that:
- `insert data` – for at least 4 tables; at least one statement must violate referential integrity constraints;
- `update data` – for at least 3 tables;
- `delete data` – for at least 2 tables.

In the `UPDATE / DELETE` statements, use at least once: `{AND, OR, NOT}`,  `{<,<=,=,>,>=,<>}`, `IS [NOT] NULL`, `IN`, `BETWEEN`, `LIKE`.

On the same database, write the following SQL queries:
- 2 queries with the union operation; use `UNION [ALL]` and `OR`;
- 2 queries with the intersection operation; use `INTERSECT` and `IN`;
- 2 queries with the difference operation; use `EXCEPT` and `NOT IN`;
- 4 queries with `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, and `FULL JOIN` (one query per operator); one query will join at least 3 tables, while another one will join at least two many-to-many relationships;
- 2 queries with the `IN` operator and a subquery in the `WHERE` clause; in at least one case, the subquery must include a subquery in its own `WHERE` clause;
- 2 queries with the `EXISTS` operator and a subquery in the `WHERE` clause;
- 2 queries with a subquery in the `FROM` clause;                       
- 4 queries with the `GROUP BY` clause, 3 of which also contain the `HAVING` clause; 2 of the latter will also have a subquery in the `HAVING` clause; use the aggregation operators: `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`;
- 4 queries using `ANY` and `ALL` to introduce a subquery in the `WHERE` clause (2 queries per operator); rewrite 2 of them with aggregation operators, and the other 2 with `IN / [NOT] IN`.

You must use:
- arithmetic expressions in the `SELECT` clause in at least 3 queries;
- conditions with `AND`, `OR`, `NOT`, and parentheses in the `WHERE` clause in at least 3 queries;
- `DISTINCT` in at least 3 queries, `ORDER BY` in at least 2 queries, and `TOP` in at least 2 queries.

## Altering the Database

Sometimes, after you design a database, you need to change its structure. Unfortunately, changes aren’t correct every time, so they must be reverted. Create a versioning mechanism that allows you to easily switch between database versions.

Write SQL scripts that:
- modify the `type of a column`;
- add / remove a `column`;
- add / remove a `DEFAULT constraint`;
- add / remove a `primary key`;
- add / remove a `candidate key`;
- add / remove a `foreign key`;
- create / drop a `table`.

For each of the scripts above, write another one that reverts the operation. Place each script in a stored procedure. Use a simple, intuitive naming convention.

Create a new table that holds the current version of the database schema. Simplifying assumption: the version is an integer number.

Write a stored procedure that receives as a parameter a version number and brings the database to that version.

## Database Testing

After you finished designing your database, the development team is interested in assessing the performance of your design. To record different test configurations and results, you create the following relational structure:

`Tests` – holds data about different tests;\
`Tables` – holds data about tables that can take part in tests;\
`TestTables` – junction table between Tests and Tables (which tables take part in which tests);\
`Views` – holds data about a set of views from the database, used to assess the performance of certain SQL queries;\
`TestViews` – junction table between Tests and Views (which views take part in which tests);\
`TestRuns` – contains data about different test runs;

A test can be run multiple times; running test T involves:
- deleting the data from test T’s tables, in the order specified by the Position field in table TestTables;
- inserting data into test T’s tables in reverse deletion order; the number of records to insert into each table is stored in the NoOfRows field in table TestTables;
- evaluating test T’s views;

`TestRunTables` – contains performance data for INSERT operations for each table in each test run;\
`TestRunViews` – contains performance data for each view in each test run. See example here.

Your task is to implement a set of stored procedures to run tests and store their results. Your tests must include at least 3 tables:
- a table with a single-column primary key and no foreign keys;
- a table with a single-column primary key and at least one foreign key;
- a table with a multicolumn primary key, 

and 3 views:
- a view with a SELECT statement operating on one table;
- a view with a SELECT statement that operates on at least 2 different tables and contains at least one JOIN operator;
- a view with a SELECT statement that has a GROUP BY clause, operates on at least 2 different tables and contains at least one JOIN operator.

Obs. The way you implement the stored procedures and / or functions is up to you. Results which allow the system to be extended to new tables / views with minimal or no code at all will be more appreciated.

## Indexes

Work on 3 tables of the form `Ta(aid, a2, …)`, `Tb(bid, b2, …)`, `Tc(cid, aid, bid, …)`, where:
- aid, bid, cid, a2, b2 are integers;
- the primary keys are underlined;
- a2 is UNIQUE in Ta;
- aid and bid are foreign keys in Tc, referencing the primary keys in Ta and Tb, respectively.

a. Write queries on Ta such that their execution plans contain the following operators:
- `clustered index scan`;
- `clustered index seek`;
- `nonclustered index scan`;
- `nonclustered index seek`;
- `key lookup`.

b. Write a query on table Tb with a WHERE clause of the form WHERE b2 = value and analyze its execution plan. Create a `nonclustered index` that can speed up the query. Examine the execution plan again.

c. Create a view that joins at least 2 tables. Check whether existing indexes are helpful; if not, reassess existing indexes / examine the cardinality of the tables.
