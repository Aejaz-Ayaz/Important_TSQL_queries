-------------- Important T-SQL queries for coding:

-- To create a DB:

create database practice_db

-- To create tables in DB:

-- with a primary key:
create table department (departid int, departname varchar(25), PRIMARY KEY(departid))

-- with a foreign key:
create table employee (empid int, firstname varchar(25), lastname varchar(25), phonenumber varchar(15), address_ varchar(255), departid int FOREIGN KEY REFERENCES department(departid))

-- insert values in table:
insert into department values (100, 'tech sup'),(200, 'MCS'),(300, 'DBA')
insert into employee values (001, 'Aejaz', 'ayaz', '1234567890', 'street123 silk board', 100),(002, 'Sudarshan', 'Satagopan', '4567981230', 'street231,Maleshwarm', 100),(003, 'Rohith', 'Singh', '7894561320', 'street321, wrangle', 200),(004, 'harsha', 'reddy', '4561327890', 'street121, nellur',  300)

-- read rows from table:
select * from department
select * from employee

-- get all the tables in a given db:
select * from INFORMATION_SCHEMA.TABLES



-- get all the dbs in a given instance:
select * from sys.databases


--Commands for DDL
--Five types of DDL commands are:

--CREATE
--CREATE statements is used to define the database structure schema:

--Syntax:

--CREATE TABLE TABLE_NAME (COLUMN_NAME DATATYPES[,....]); 
--For example:

--Create database university;
--Create table students;
--Create view for_students;
--DROP
--Drops commands remove tables and databases from RDBMS.

--Syntax:

--DROP TABLE ;  
--For example:

--Drop object_type object_name;
--Drop database university;
--Drop table student;
--ALTER
--Alters command allows you to alter the structure of the database.

--Syntax:

--To add a new column in the table

--ALTER TABLE table_name ADD column_name COLUMN-definition;  
--To modify an existing column in the table:

--ALTER TABLE MODIFY(COLUMN DEFINITION....); 
--For example:

--Alter table guru99 add subject varchar;
--TRUNCATE:
--This command used to delete all the rows from the table and free the space containing the table.

--Syntax:

--TRUNCATE TABLE table_name;  
--Example:

--TRUNCATE table students;
--Commands for DML
--Here are some important DML commands:

--INSERT
--UPDATE
--DELETE
--INSERT:
--This is a statement that is a SQL query. This command is used to insert data into the row of a table.

--Syntax:

--INSERT INTO TABLE_NAME  (col1, col2, col3,.... col N)  
--VALUES (value1, value2, value3, .... valueN);  
--Or 
--INSERT INTO TABLE_NAME    
--VALUES (value1, value2, value3, .... valueN);    
--For example:

--INSERT INTO students (RollNo, FIrstName, LastName) VALUES ('60', 'Tom', 'Erichsen');
--UPDATE:
--This command is used to update or modify the value of a column in the table.

--Syntax:

--UPDATE table_name SET [column_name1= value1,...column_nameN = valueN] [WHERE CONDITION]   
--For example:

--UPDATE students    
--SET FirstName = 'Jhon', LastName=' Wick' 
--WHERE StudID = 3;
--DELETE:
--This command is used to remove one or more rows from a table.

--Syntax:

--DELETE FROM table_name [WHERE condition];
--For example:

--DELETE FROM students 
--WHERE FirstName = 'Jhon';  


-- order results in acensending or decending repectively
select * from employee order by firstname
select * from employee order by firstname desc

-- alter table column to non nullable
alter table employee alter column empid int NOT NULL

-- alter table column to set it as primary key
ALTER TABLE employee ADD CONSTRAINT pk_emp PRIMARY KEY (empid)

-- create another table using a pk from above and insert values
create table salary(empid int FOREIGN KEY REFERENCES employee(empid), empname varchar(25), sal MONEY)
insert into salary values (001, 'aejazayaz', 5000),(002, 'sudarshan', 10000),(003, 'rohith', 15000),(004, 'harsha', 7000)

-- DISTINCT values:
select DISTINCT departid from employee

-- NULL values:
insert into employee values (005, 'mahesh', 'prakash', NULL , 'vijaynagar', 200)

select * from employee where phonenumber IS NOT NULL
select * from employee where phonenumber IS NULL
-- note '' is not same as NULL

-- update value:
update employee set address_ = 'vijayanagara' where empid = 005
-- Be careful when updating records. If you omit the WHERE clause, ALL records will be updated!

-- delete values:
delete from employee where empid = 005
-- if u omit where clause, all the records will be deleted

-- select top or limit 
select top(2) * from employee

-- min and max:
select min(sal) as min_salary from salary
select max(sal) as min_salary from salary

-- count, avg, sum
select count(*) from employee
select avg(sal) from salary
select sum(sal) from salary

-- Like operator and the wildcards:

--%	Represents zero or more characters	bl% finds bl, black, blue, and blob
--_	Represents a single character	h_t finds hot, hat, and hit
--[]	Represents any single character within the brackets	h[oa]t finds hot and hat, but not hit
--^	Represents any character not in the brackets	h[^oa]t finds hit, but not hot and hat
---	Represents any single character within the specified range	c[a-b]t finds cat and cbt

select * from employee where firstname like '%aej%'
select * from employee where firstname like '%z'
select * from employee where firstname like 'a%z'
select * from employee where firstname like '_____'
select * from employee where firstname like 'a_j_z'
select * from employee where firstname like '[ahs]%'
select * from employee where firstname like '[a-r]%'
select * from employee where firstname like '[^ahs]%'



-- in, between
select * from employee where firstname in ('aejaz', 'harsha')
select * from employee where firstname not in ('aejaz', 'harsha')


select empname from salary where sal between 1000 and 10000


-- alias
select empname as name from salary

select empname from salary as s where s.sal = 5000

-- joins
insert into department values (400, 'EHR')
select * from employee as e join department as d on e.departid=d.departid

--Here are the different types of the JOINs in SQL:

--(INNER) JOIN: Returns records that have matching values in both tables
--LEFT (OUTER) JOIN: Returns all records from the left table, and the matched records from the right table
--RIGHT (OUTER) JOIN: Returns all records from the right table, and the matched records from the left table
--FULL (OUTER) JOIN: Returns all records when there is a match in either left or right table
--SQL Self Join
--A self join is a regular join, but the table is joined with itself.

select * from employee as e join salary as s on e.empid=s.empid
select * from employee as e left join salary as s on e.empid=s.empid
select * from employee as e right join salary as s on e.empid=s.empid
select * from employee as e full join salary as s on e.empid=s.empid
select * from employee as e, employee as e1 where e.departid=e1.departid   --self join

-- group by:
select count(*), departid from employee group by departid

-- having:
select count(*), departid from employee group by departid having count(*) >= 2

-- exists:
select firstname from employee where exists (select departname from department where employee.departid=department.departid)

-- select into: copies from old table to new table (it creates new one)
select firstname, lastname into employee_names from employee

-- insert into: here u need to have a table ready with same structure
insert into employees_addres 
select address_ from employee


-- case: you can have multiple whenthen statments
select empname, sal, 
case
when sal >= 10000 then 'more salary'
else 'less salary'
end as moreorless
from salary



--Stored Procedure Syntax
--CREATE PROCEDURE procedure_name
--AS
--sql_statement
--GO;

--Execute a Stored Procedure
--EXEC procedure_name;





--SQL Arithmetic Operators
--Operator	Description	Example
-- +	Add	
-- -	Subtract	
-- *	Multiply	
-- /	Divide	
-- %	Modulo	
--SQL Bitwise Operators
--Operator	Description
-- &	Bitwise AND
-- |	Bitwise OR
-- ^	Bitwise exclusive OR
--SQL Comparison Operators
--Operator	Description	Example
-- =	Equal to	
-- >	Greater than	
-- <	Less than	
-- >=	Greater than or equal to	
-- <=	Less than or equal to	
-- <>	Not equal to	
--SQL Compound Operators
--Operator	Description
-- +=	Add equals
-- -=	Subtract equals
-- *=	Multiply equals
-- /=	Divide equals
-- %=	Modulo equals
-- &=	Bitwise AND equals
-- ^-=	Bitwise exclusive equals
-- |*=	Bitwise OR equals
-- SQL Logical Operators
-- Operator	Description	Example
-- ALL	TRUE if all of the subquery values meet the condition	
-- AND	TRUE if all the conditions separated by AND is TRUE	
-- ANY	TRUE if any of the subquery values meet the condition	
--BETWEEN	TRUE if the operand is within the range of comparisons	
--EXISTS	TRUE if the subquery returns one or more records	
--IN	TRUE if the operand is equal to one of a list of expressions	
--LIKE	TRUE if the operand matches a pattern	
--NOT	Displays a record if the condition(s) is NOT TRUE	
--OR	TRUE if any of the conditions separated by OR is TRUE	
--SOME	TRUE if any of the subquery values meet the condition