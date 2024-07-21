CREATE DATABASE subqueries;
SHOW DATABASES;
USE subqueries;



-- Creating the department table
CREATE TABLE department (
    dept_id INT,
    dept_name VARCHAR(50) PRIMARY KEY,
    location VARCHAR(100)
);

-- Inserting values into the department table
INSERT INTO department VALUES 
(1, 'Admin', 'Bangalore'),
(2, 'HR', 'Bangalore'),
(3, 'IT', 'Bangalore'),
(4, 'Finance', 'Mumbai'),
(5, 'Marketing', 'Bangalore'),
(6, 'Sales', 'Mumbai');

-- Creating the EMPLOYEE table
CREATE TABLE employee(
    EMP_ID      INT PRIMARY KEY,
    EMP_NAME    VARCHAR(50) NOT NULL,
    DEPT_NAME   VARCHAR(50) NOT NULL,
    SALARY      INT,
    CONSTRAINT fk_emp FOREIGN KEY(dept_name) REFERENCES department(dept_name)
);

-- Inserting values into the EMPLOYEE table
INSERT INTO EMPLOYEE VALUES
(101, 'Mohan', 'Admin', 4000),
(102, 'Rajkumar', 'HR', 3000),
(103, 'Akbar', 'IT', 4000),
(104, 'Dorvin', 'Finance', 6500),
(105, 'Rohit', 'HR', 3000),
(106, 'Rajesh', 'Finance', 5000),
(107, 'Preet', 'HR', 7000),
(108, 'Maryam', 'Admin', 4000),
(109, 'Sanjay', 'IT', 6500),
(110, 'Vasudha', 'IT', 7000),
(111, 'Melinda', 'IT', 8000),
(112, 'Komal', 'IT', 10000),
(113, 'Gautham', 'Admin', 2000),
(114, 'Manisha', 'HR', 3000),
(115, 'Chandni', 'IT', 4500),
(116, 'Satya', 'Finance', 6500),  
(117, 'Adarsh', 'HR', 3500),
(118, 'Tejaswi', 'Finance', 5500),
(119, 'Cory', 'HR', 8000),
(120, 'Monica', 'Admin', 5000),
(121, 'Rosalin', 'IT', 6000),
(122, 'Ibrahim', 'IT', 8000),
(123, 'Vikram', 'IT', 8000),
(124, 'Dheeraj', 'IT', 11000);

-- Creating the employee_history table
CREATE TABLE employee_history (
    emp_id      INT PRIMARY KEY,
    emp_name    VARCHAR(50) NOT NULL,
    dept_name   VARCHAR(50),
    salary      INT,
    location    VARCHAR(100),
    CONSTRAINT fk_emp_hist_01 FOREIGN KEY(dept_name) REFERENCES department(dept_name),
    CONSTRAINT fk_emp_hist_02 FOREIGN KEY(emp_id) REFERENCES EMPLOYEE(emp_id)
);

-- Creating the sales table
CREATE TABLE sales (
    store_id        INT,
    store_name      VARCHAR(50),
    product_name    VARCHAR(50),
    quantity        INT,
    price           INT
);

-- Inserting values into the sales table
INSERT INTO sales VALUES
(1, 'Apple Store 1', 'iPhone 13 Pro', 1, 1000),
(1, 'Apple Store 1', 'MacBook pro 14', 3, 6000),
(1, 'Apple Store 1', 'AirPods Pro', 2, 500),
(2, 'Apple Store 2', 'iPhone 13 Pro', 2, 2000),
(3, 'Apple Store 3', 'iPhone 12 Pro', 1, 750),
(3, 'Apple Store 3', 'MacBook pro 14', 1, 2000),
(3, 'Apple Store 3', 'MacBook Air', 4, 4400),
(3, 'Apple Store 3', 'iPhone 13', 2, 1800),
(3, 'Apple Store 3', 'AirPods Pro', 3, 750),
(4, 'Apple Store 4', 'iPhone 12 Pro', 2, 1500),
(4, 'Apple Store 4', 'MacBook pro 16', 1, 3500);

-- Selecting all records from the tables
SELECT * FROM EMPLOYEE;
SELECT * FROM department;
SELECT * FROM employee_history;
SELECT * FROM sales;












-- ----------------------------------------------------------------------------------------------------------------

/* QUESTION: Find the employees who's salary is more than the average salary earned by all employees. */
-- 1) find the avg salary
-- 2) filter employees based on the above avg salary

SELECT AVG(SALARY) FROM employee; --  5791.6667
SELECT * 
FROM employee
where salary> 5791.6667;


SELECT *  -- outer query/ main query
FROM employee
where salary> (SELECT AVG(SALARY) FROM employee); -- subquery/ inner query







-- TYPES OF SUBQUERY
-- ---------------------------------------------------------------------------------------------------------------------------
/* < SCALAR SUBQUERY > */

/* QUESTION: Find the employees who earn more than the average salary earned by all employees. */
-- it return exactly 1 row and 1 column

select *
from employee 
where salary > (select avg(salary) from employee)
order by employee.salary;



select e.*
from employee e
join (select avg(salary) sal from employee)  avg_sal
	on e.salary > avg_sal.sal;



-- ------------------------------------------------------------------------------
/* < MULTIPLE ROW SUBQUERY > */ 
-- multiplecolumn, multiplerow (2 types)
-- Multiple column, multiple row 

/* QUESTION: Find the employees who earn the highest salary in each department. */
-- 1) find the highest salary in each department.
-- 2) filter the employees based on above result.

-- subquery
select dept_name, max(salary)
from employee 
group by dept_name;




select *
from employee e
where (dept_name,salary)in(
      select dept_name, max(salary) 
      from employee 
      group by dept_name)
order by dept_name, salary;






-- Single column, multiple row subquery
/* QUESTION: Find department who do not have any employees */
-- 1) find the departments where employees are present.
-- 2) from the department table filter out the above results.

-- subquery
select distinct dept_name from employee;



select *
from department
where dept_name not in(
    select distinct dept_name
    from employee);





-- ------------------------------------------------------------------------------
-- < CORRELATED SUBQUERY >
-- A subquery which is related to the Outer query
/* QUESTION: Find the employees in each department who earn more than the average salary in that department. */

-- 1) find the avg salary per department
-- 2) filter data from employee tables based on avg salary from above result.



SELECT *
FROM employee e
WHERE salary > (
    SELECT AVG(salary)
    FROM employee e2
    WHERE e2.dept_name = e.dept_name
)
ORDER BY dept_name, salary;





/* QUESTION: Find department who do not have any employees */
-- Using correlated subquery



select *
from department d
where not exists (
   select 1
   from employee e 
   where e.dept_name = d.dept_name);



-- ------------------------------------------------------------------------------
/* < SUBQUERY inside SUBQUERY (NESTED Query/Subquery)> */

/* QUESTION: Find stores who's sales where better than the average sales accross all stores 
1) find the sales for each store
2) average sales for all stores
3) compare 2 with 1  */
-- Using multiple subquery



select *
from (select store_name, sum(price) as total_sales
	 from sales
	 group by store_name) sales
join (select avg(total_sales) as avg_sales
	 from (select store_name, sum(price) as total_sales
		  from sales
		  group by store_name) x
	 ) avg_sales
on sales.total_sales > avg_sales.avg_sales;




-- Using WITH clause


with sales as
	(select store_name, sum(price) as total_sales
	 from sales
	 group by store_name)
select *
from sales
join (select avg(total_sales) as avg_sales from sales) avg_sales
	on sales.total_sales > avg_sales.avg_sales;



-- CLAUSES WHERE SUBQUERY CAN BE USED
-- ------------------------------------------------------------------------------
/* < Using Subquery in WHERE clause > */
/* QUESTION:  Find the employees who earn more than the average salary earned by all employees. */
select *
from employee e
where salary > (select avg(salary) from employee)
order by e.salary;


-- ------------------------------------------------------------------------------
/* < Using Subquery in FROM clause > */
/* QUESTION: Find stores who's sales where better than the average sales accross all stores */
-- Using WITH clause
with sales as
	(select store_name, sum(price) as total_sales
	 from sales
	 group by store_name)
select *
from sales
join (select avg(total_sales) as avg_sales from sales) avg_sales
	on sales.total_sales > avg_sales.avg_sales;


-- ------------------------------------------------------------------------------
/* < USING SUBQUERY IN SELECT CLAUSE > */
-- Only subqueries which return 1 row and 1 column is allowed (scalar or correlated)
/* QUESTION: Fetch all employee details and add remarks to those employees who earn more than the average pay. */
select e.*
, case when e.salary > (select avg(salary) from employee)
			then 'Above average Salary'
	   else null
  end remarks
from employee e;

-- Alternative approach
select e.*
, case when e.salary > avg_sal.sal
			then 'Above average Salary'
	   else null
  end remarks
from employee e
cross join (select avg(salary) sal from employee) avg_sal;



-- ------------------------------------------------------------------------------
/* < Using Subquery in HAVING clause > */
/* QUESTION: Find the stores who have sold more units than the average units sold by all stores. */
select store_name, sum(quantity) Items_sold
from sales
group by store_name
having sum(quantity) > (select avg(quantity) from sales);




-- SQL COMMANDS WHICH ALLOW A SUBQUERY
-- ------------------------------------------------------------------------------
/* < Using Subquery with INSERT statement > */
/* QUESTION: Insert data to employee history table. Make sure not insert duplicate records. */
insert into employee_history
select e.emp_id, e.emp_name, d.dept_name, e.salary, d.location
from employee e
join department d on d.dept_name = e.dept_name
where not exists (select 1
				  from employee_history eh
				  where eh.emp_id = e.emp_id);


-- ------------------------------------------------------------------------------
/* < Using Subquery with UPDATE statement > */
/* QUESTION: Give 10% increment to all employees in Bangalore location based on the maximum
salary earned by an emp in each dept. Only consider employees in employee_history table. */
update employee e
set salary = (select max(salary) + (max(salary) * 0.1)
			  from employee_history eh
			  where eh.dept_name = e.dept_name)
where dept_name in (select dept_name
				   from department
				   where location = 'Bangalore')
and e.emp_id in (select emp_id from employee_history);


-- ------------------------------------------------------------------------------
/* < Using Subquery with DELETE statement > */
/* QUESTION: Delete all departments who do not have any employees. */
delete from department d1
where dept_name in (select dept_name 
                    from department d2
				    where not exists (
                         select 1 from employee e
						 where e.dept_name = d2.dept_name));







