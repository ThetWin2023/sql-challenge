/*--------------------------------------------------------------------
* Data Analytics and Visualization Bootcamp (University of Toronto) 
* Student Name: Thet Win
* Date Modified: June 29, 2024
* Module 9 Challenge - SQL
*/--------------------------------------------------------------------
 

-- 1. Create a employees table
CREATE TABLE employees (
    emp_no INT PRIMARY KEY,
    birth_date VARCHAR(50) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    sex VARCHAR(50) NOT NULL,
    hire_date DATE NOT NULL
);

-- 2. Create a titles table
CREATE TABLE titles (
    title_id VARCHAR(50) PRIMARY KEY,
    title VARCHAR(50) NOT NULL
);

-- 3. Create a titles table
CREATE TABLE titles (
    title_id VARCHAR(50) PRIMARY KEY,
    title VARCHAR(50) NOT NULL
);

-- 4. Create a departments table
CREATE TABLE departments (
    dept_no VARCHAR(50) PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL
);

-- 5. Create a dept_emp table
-- It is noted that both of these fields contain duplicate values
CREATE TABLE dept_emp (
    emp_no INT NOT NULL,
    dept_no VARCHAR(50) NOT NULL
);

-- 6. Create a dept_manager table
CREATE TABLE dept_manager (
    dept_no VARCHAR(50) NOT NULL,
    emp_no INT PRIMARY KEY
);

-- 7. Create a salaries table
CREATE TABLE salaries (
	emp_no INT PRIMARY KEY,
	salary INT NOT NULL
);

-- Create Foreign Key for Employees Table that references the Primary Key of Titles table
ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

-- Add Serial key id as Primary key to dept_emp table.
ALTER TABLE dept_emp ADD COLUMN id SERIAL PRIMARY KEY;

-- Create Foreign Key for Dept. Manager Table that references the Primary Key of Employees table
ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

-- Create Foreign Key for Salaries Table that references the Primary Key of Employees table
ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");


/*
---------------
 DATA ANALYSIS
---------------
*/

-- 1. List the employee number, last name, first name, sex, and salary of each employee.
SELECT 
	a.emp_no AS "Employee Number",
	a.last_name AS "Last Name",
	a.first_name AS "First Name",
	a.sex AS "Sex",
	b.salary AS "Salary"
FROM employees a 
JOIN salaries b 
ON a.emp_no = b.emp_no 
;

-- 2. List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT 
	first_name AS "First Name",
	last_name AS "Last Name",
	hire_date AS "Hire Date"
FROM employees 
WHERE DATE_PART('YEAR', hire_date) = 1986 
;
 
-- 3. List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT 
	a.dept_no AS "Department Number",
	a.emp_no AS "Employee ID",
	b.dept_name AS "Department Name",
	c.last_name AS "Last Name",
	c.first_name AS "First Name"
FROM dept_manager a
JOIN departments b ON a.dept_no = b.dept_no
JOIN employees c ON a.emp_no = c.emp_no
; 
 
-- 4. List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT 
	a.dept_no AS "Department Number",
	a.emp_no AS "Employee ID",
	b.last_name AS "Last Name",
	b.first_name AS "First Name",
	c.dept_name AS "Department Name"
FROM dept_emp a
JOIN employees b ON a.emp_no = b.emp_no 
JOIN departments c ON a.dept_no = c.dept_no
;

-- 5. List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT 
	a.first_name AS "First Name",
	a.last_name AS "Last Name",
	a.sex AS "Sex"
FROM employees a
WHERE TRIM(UPPER(a.first_name)) = 'HERCULES'
AND TRIM(UPPER(a.last_name)) LIKE 'B%'
;

-- 6. List each employee in the Sales department, including their employee number, last name, and first name.
SELECT 
a.emp_no AS "Employee ID",
a.last_name AS "Last Name",
a.first_name AS "First Name",
c.dept_name AS "Department Name"
FROM employees a 
JOIN dept_emp b ON a.emp_no = b.emp_no 
JOIN departments c ON b.dept_no = c.dept_no 
WHERE c.dept_name = 'Sales'
;


-- 7. List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT 
a.emp_no AS "Employee ID",
a.last_name AS "Last Name",
a.first_name AS "First Name",
c.dept_name AS "Department Name"
FROM employees a 
JOIN dept_emp b ON a.emp_no = b.emp_no 
JOIN departments c ON b.dept_no = c.dept_no 
WHERE c.dept_name IN ('Sales', 'Development')
;

-- 8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT 
	COUNT(*), 
	last_name AS "Last Name"
FROM employees
GROUP BY last_name
ORDER BY last_name DESC
;
