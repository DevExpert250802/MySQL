##   SUBQUERY

## Q: Find the employees whose salary is more than the average salary earned by all employees.
## 1. Find the average salary
## 2. Filter employees based on the above avg salary


```sql
SELECT AVG(SALARY) FROM employee; --  5791.6667
SELECT * 
FROM employee
where salary> 5791.6667;
-- Approach not Dynamic
```
```sql
SELECT *  -- outer query/ main query
FROM employee
where salary> (SELECT AVG(SALARY) FROM employee); -- subquery/ inner query
```

##  TYPES OF SUBQUERY

##  SCALAR SUBQUERY (it returns exactly 1 row and 1 column)
## Q: Find the employees whose salary is more than the average salary earned by all employees.

```sql
select *
from employee 
where salary > (select avg(salary) from employee)
order by employee.salary;
```
```sql
select e.*
from employee e
join (select avg(salary) sal from employee)  avg_sal
	on e.salary > avg_sal.sal;
```

##  MULTIPLE ROW SUBQUERY
## -- multiple-column, multiple-row (2 types)

## -- multiple columns, multiple rows 
## Q: Find the employees who earn the highest salary in each department.


```sql
select *
from employee e
where (dept_name,salary)in(
      select dept_name, max(salary) 
      from employee 
      group by dept_name)
order by dept_name, salary;
```


## -- Single column, multiple row subquery
## Q: Find a department who do not have any employees

```sql
select *
from department
where dept_name not in(
    select distinct dept_name
    from employee);

```

## How can I manually create tables and insert data?

```sql

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
```

## Select all the data

```sql
SELECT * FROM EMPLOYEE;
SELECT * FROM department;
SELECT * FROM employee_history;
SELECT * FROM sales;
```
