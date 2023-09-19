USE tutorial;

CREATE TABLE employee(
    emp_id VARCHAR(20),
    emp_name VARCHAR(50),
    salary INT,
    dept_id VARCHAR(20),
    manager_id VARCHAR(20)
);

INSERT INTO employee VALUES
('E1', 'Rahul', 15000, 'D1', 'M1'),
('E2', 'Manoj', 15000, 'D1', 'M1'),
('E3', 'James', 55000, 'D2', 'M2'),
('E4', 'Michael', 25000, 'D2', 'M2'),
('E5', 'Ali', 20000, 'D10', 'M3'),
('E6', 'Robin', 35000, 'D10', 'M3');

CREATE TABLE department(
    dept_id VARCHAR(20),
    dept_name VARCHAR(50)
);

INSERT INTO department VALUES
('D1', 'IT'),
('D2', 'HR'),
('D3', 'Finance'),
('D4', 'Admin');

CREATE TABLE managers(
    manager_id VARCHAR(20),
    manager_name VARCHAR(50),
    dept_id VARCHAR(20)
);

INSERT INTO managers VALUES
('M1', 'Prem', 'D3'),
('M2', 'Shripadh', 'D4'),
('M3', 'Nick', 'D1'),
('M4', 'Cory', 'D1');

CREATE TABLE projects(
    project_id VARCHAR(20),
    project_name VARCHAR(50),
    team_member_id VARCHAR(20)
);

INSERT INTO projects VALUES
('P1', 'Data Migration', 'E1'),
('P1', 'Data Migration', 'E2'),
('P1', 'Data Migration', 'M3'),
('P2', 'ETL Tool', 'E1'),
('P2', 'ETL Tool', 'M4');

SELECT * FROM employee;
SELECT * FROM department;
SELECT * FROM managers;
SELECT * FROM projects;

/* Fetch the employee name and the department name they 
belong to */
/* USE INNER JOIN / JOIN to fetch emp_name from 
employee table and dept_name from department table */
SELECT emp_name, dept_name
FROM employee e
INNER JOIN department d
ON e.dept_id = d.dept_id; 

/* Fetch ALL the employee names and the department name
they belong to */
-- LEFT JOIN = INNER JOIN + any additional records from the left table
SELECT emp_name, dept_name
FROM employee e
LEFT JOIN department d
ON e.dept_id = d.dept_id;

/* Fetch ALL department names and their employees */
--RIGHT JOIN = INNER JOIN + any additional records from the right table 
SELECT emp_name, dept_name
FROM employee e
RIGHT JOIN department d
ON e.dept_id = d.dept_id;

/* Fetch ALL employees, their managers, department and
the projects they work on */
SELECT
    e.emp_name,
    m.manager_name,
    d.dept_name,
    p.project_name
FROM employee e
LEFT JOIN managers m ON e.manager_id = m.manager_id
INNER JOIN department d ON d.dept_id = e.dept_id
LEFT JOIN projects p ON p.team_member_id = e.emp_id;

/* Fetch ALL employee names and department names */
-- FULL OUTER JOIN = INNER JOIN + RIGHT JOIN + LEFT JOIN
SELECT emp_name, dept_name
FROM employee e
RIGHT JOIN department d
ON d.dept_id = e.dept_id
UNION
SELECT e.emp_name, d.dept_name
FROM employee e
LEFT JOIN department d
ON d.dept_id = e.dept_id;

-- CROSS JOIN / CARTESIAN JOIN
-- Returns a cartesian product
CREATE TABLE company(
    company_id VARCHAR(10),
    company_name VARCHAR(50),
    location VARCHAR(20)
);

INSERT INTO company VALUES
('C001', 'D.A Tech Solutions', 'Nairobi, Kenya');

SELECT * FROM company;

/* Write a query to fetch the employee name and their department names
along with the company name and the company location corresponding
to each employee */
SELECT e.emp_name, d.dept_name, c.company_name, c.location
FROM employee e
INNER JOIN department d
ON e.dept_id = d.dept_id
CROSS JOIN company c;

--SELF JOIN
CREATE TABLE family(
    member_id VARCHAR(10),
    name VARCHAR(50),
    age INT,
    parent_id VARCHAR(10)
);

INSERT INTO family VALUES
('F1', 'David', 4, 'F5'),
('F2', 'Carol', 10, 'F5'),
('F3', 'Michael', 12, 'F5'),
('F4', 'Johnson', 36, NULL),
('F5', 'Maryam', 40, 'F6'),
('F6', 'Stewart', 70, NULL),
('F7', 'Rohan', 6, 'F4'),
('F8', 'Asha', 8, 'F4');

SELECT * FROM family;

/* Write a query to fetch the child name and their age along with the parent
name and age */
SELECT
    child.name AS child_name,
    child.age AS child_age,
    parent.name AS parent_name,
    parent.age AS parent_age
FROM family AS child
JOIN family AS parent
ON child.parent_id = parent.member_id;