##      JOINS &  SET OPERATIONS

## JOINS :
## 1. Inner JOIN

```sql
SELECT *
FROM customer
JOIN event
ON customer.customer_id = event.customer_id;
```

## JOIN  without using JOIN keyword
```sql
SELECT * 
FROM customer, event
WHERE customer.customer_id = event.customer_id;
```

## -- Alias in MySQL (AS)

```sql
SELECT c.*,e.* 
FROM customer AS c 
INNER JOIN event AS e
ON c.customer_id = e.customer_id;
```

## For specific coulums in Inner JOIN

```sql 
SELECT customer.customer_id, customer.name, event.event_id, event.action
FROM customer
JOIN event
ON customer.customer_id = event.customer_id;
```


## 2. Left JOIN

```sql
SELECT *
FROM customer
LEFT JOIN event
ON customer.customer_id = event.customer_id;
```

## Left Outer JOIN with Exclusion

```sql
SELECT *
FROM customer
LEFT JOIN event
ON customer.customer_id = event.customer_id
WHERE event.customer_id IS NULL;
```

## 3.  Right JOIN

```sql
SELECT *
FROM event_v2
RIGHT JOIN action
ON event_v2.action_id = action.action_id;
```

## Rewrite as Left JOIN

```sql
SELECT *
FROM action
LEFT JOIN event_v2
ON action.action_id = event_v2.action_id;
```

## Join 3 tables

```sql
SELECT * 
FROM action
LEFT JOIN event_v2
ON action.action_id = event_v2.action_id 
LEFT JOIN customer
ON event_v2.customer_id  = customer.customer_id;
```

## Select only customer and action names

```sql
SELECT action.name, customer.name
FROM action
LEFT JOIN event_v2
ON action.action_id = event_v2.action_id 
LEFT JOIN customer
ON event_v2.customer_id  = customer.customer_id;
```

## 4.  Full JOIN (Left JOIN + RIGHT JOIN)

```sql
SELECT *
FROM teacher
LEFT JOIN student 
ON teacher.age = student.age
UNION
SELECT *
FROM teacher
RIGHT JOIN student
ON teacher.age = student.age;
```
```sql
SELECT teacher.*, student.*
FROM teacher
LEFT JOIN student 
ON teacher.age = student.age
UNION
SELECT teacher.*, student.*
FROM teacher 
RIGHT JOIN student 
ON teacher.age = student.age;
```
```sql
SELECT *
FROM teacher AS t
LEFT JOIN student  AS s
ON t.age = s.age
UNION
SELECT *
FROM teacher AS t
RIGHT JOIN student  AS s
ON t.age = s.age;
```

## 5. CROSS JOIN

```sql
SELECT *
FROM teacher
CROSS JOIN student;
```

## 6. SELF JOIN

```sql
SELECT T1.employee_name AS empname,T2.empname AS manager_name
FROM emp AS T1
JOIN emp AS T2
ON T1.empid=T2.managerid;
```

## SET OPERATIONS (UNION, INTERSECT, MINUS)  :

## 1.  UNION

```sql
SELECT age 
FROM teacher
UNION 
SELECT age
FROM student;
```

## UNION ALL

```sql
SELECT age
FROM teacher
UNION ALL
SELECT age
FROM student;
```

## 2.  INTERSECT

```sql
SELECT DISTINCT teacher.age
FROM teacher 
JOIN student 
ON teacher.age = student.age;
```

```sql
SELECT  DISTINCT age 
FROM teacher
JOIN  student
using (age);
```

## 3.  MINUS

## T1 - T2
```sql
SELECT  age  
FROM teacher
LEFT JOIN  student
using (age)
WHERE student.age IS NULL;
```

## T2 - T1
```sql
SELECT  age 
FROM teacher
RIGHT JOIN  student
using (age)
WHERE teacher.age IS NULL;
```


## How can I manually create tables and insert data?

```sql

CREATE DATABASE student;
SHOW DATABASES;
USE student;


CREATE TABLE customer (
  customer_id integer PRIMARY KEY, 
  name varchar(256), 
  address varchar(256)
);

INSERT INTO customer
VALUES 
  (1, 'Casey', '2295 Spring Avenue'), 
  (2, 'Peter', '924 Emma Street'), 
  (3, 'Erika', '397 Terry Lane');

CREATE TABLE event (
  event_id integer PRIMARY KEY, 
  customer_id integer REFERENCES customer(customer_id), 
  action varchar(256)
);

INSERT INTO event
VALUES 
  (101, '3', 'LOGIN'),
  (102, '3', 'VIEW PAGE'),
  (103, '1', 'LOGIN'),
  (104, '1', 'SEARCH');

CREATE TABLE action (
  action_id integer PRIMARY KEY, 
  name varchar(256)
);

INSERT INTO action
VALUES 
  (201, 'LOGIN'),
  (202, 'VIEW PAGE'),
  (203, 'SEARCH'),
  (204, 'LOGOUT');

CREATE TABLE event_v2 (
  event_id integer PRIMARY KEY, 
  customer_id integer REFERENCES customer(customer_id), 
  action_id integer REFERENCES action(action_id)
);

INSERT INTO event_v2
VALUES 
  (101, 2, 201),
  (102, 2, 204);

CREATE TABLE teacher (
  teacher_id integer PRIMARY KEY, 
  name varchar(256), 
  age integer
);

INSERT INTO teacher
VALUES 
  (1, 'Tiffany', 28),
  (2, 'Mathew', 35);

CREATE TABLE student (
  student_id integer PRIMARY KEY, 
  name varchar(256), 
  age integer
);

INSERT INTO student
VALUES 
  (1, 'Ben', 28),
  (2, 'Jenny', 21);

CREATE TABLE emp(
  empid integer PRIMARY KEY,
  empname varchar(256),
  managerid integer
  );
  
  INSERT INTO emp VALUES 
  (1, 'Agni', 3),
  (2, 'Akash', 4),
  (3, 'Dharti', 2),
  (4, 'Vayu', 3);
```

## Select all the data

```sql
SELECT * FROM customer;
SELECT * FROM event;
SELECT * FROM action;
SELECT * FROM event_v2;
SELECT * FROM teacher;
SELECT * FROM student;
SELECT * FROM emp;
```
