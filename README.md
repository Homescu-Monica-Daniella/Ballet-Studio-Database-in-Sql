# Ballet-Studio-Database-in-Sql

## Database Design

Imagine a simple application that requires a database. Represent the application data in a relational structure and implement the structure in a SQL Server database. The database must contain at least: 10 tables, two 1:n relationships, one m:n relationship.

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
