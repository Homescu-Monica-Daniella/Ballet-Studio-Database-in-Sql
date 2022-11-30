# Ballet-Studio-Database-in-Sql

## Database Design

Imagine a simple application that requires a database. Represent the application data in a relational structure and implement the structure in a SQL Server database. The database must contain at least: 10 tables, two 1:n relationships, one m:n relationship.

## SQL Queries

On the relational structure created, write SQL statements that:\
&emsp;-insert data – for at least 4 tables; at least one statement must violate referential integrity constraints;\
&emsp;-update data – for at least 3 tables;\
&emsp;-delete data – for at least 2 tables.

In the UPDATE / DELETE statements, use at least once: {AND, OR, NOT},  {<,<=,=,>,>=,<> }, IS [NOT] NULL, IN, BETWEEN, LIKE.

On the same database, write the following SQL queries:\
&emsp;a. 2 queries with the union operation; use UNION [ALL] and OR;\
&emsp;b. 2 queries with the intersection operation; use INTERSECT and IN;\
&emsp;c. 2 queries with the difference operation; use EXCEPT and NOT IN;\
&emsp;d. 4 queries with INNER JOIN, LEFT JOIN, RIGHT JOIN, and FULL JOIN (one query per operator); one query will join at least 3 tables, while another one will join at least two many-to-many relationships;\
&emsp;e. 2 queries with the IN operator and a subquery in the WHERE clause; in at least one case, the subquery must include a subquery in its own WHERE clause;\
&emsp;f. 2 queries with the EXISTS operator and a subquery in the WHERE clause;\
&emsp;g. 2 queries with a subquery in the FROM clause;\                         
&emsp;h. 4 queries with the GROUP BY clause, 3 of which also contain the HAVING clause; 2 of the latter will also have a subquery in the HAVING clause; use the aggregation operators: COUNT, SUM, AVG, MIN, MAX;\
&emsp;i. 4 queries using ANY and ALL to introduce a subquery in the WHERE clause (2 queries per operator); rewrite 2 of them with aggregation operators, and the other 2 with IN / [NOT] IN.

You must use:\
&emsp;-arithmetic expressions in the SELECT clause in at least 3 queries;\
&emsp;-conditions with AND, OR, NOT, and parentheses in the WHERE clause in at least 3 queries;\
&emsp;-DISTINCT in at least 3 queries, ORDER BY in at least 2 queries, and TOP in at least 2 queries.

## Altering the Database

Sometimes, after you design a database, you need to change its structure. Unfortunately, changes aren’t correct every time, so they must be reverted. Your task is to create a versioning mechanism that allows you to easily switch between database versions.

Write SQL scripts that:\
&emsp;a. modify the type of a column;\
&emsp;b. add / remove a column;\
&emsp;c. add / remove a DEFAULT constraint;\
&emsp;d. add / remove a primary key;\
&emsp;e. add / remove a candidate key;\
&emsp;f. add / remove a foreign key;\
&emsp;g. create / drop a table.

For each of the scripts above, write another one that reverts the operation. Place each script in a stored procedure. Use a simple, intuitive naming convention.

Create a new table that holds the current version of the database schema. Simplifying assumption: the version is an integer number.

Write a stored procedure that receives as a parameter a version number and brings the database to that version.
