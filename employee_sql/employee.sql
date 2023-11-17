-- create titles table
CREATE TABLE titles (
	title_id varchar(5) PRIMARY KEY,
	title varchar(30)
);
-- create employees table
CREATE TABLE employees (
	emp_no varchar(10) PRIMARY KEY,
	emp_title_id varchar(5) references titles(title_id),
	birth_date date,
	first_name varchar(45),
	last_name varchar(45),
	sex varchar(1),
	hire_date date
);
-- create departments table
CREATE TABLE departments (
	dept_no varchar(5) PRIMARY KEY,
	dept_name varchar(30)
);
-- create department managers table
CREATE TABLE dept_manager (
	dept_no varchar(5) references departments(dept_no),
	emp_no varchar(10)
);
-- create department employees table
CREATE TABLE dept_emp (
	emp_no varchar(10) references employees(emp_no),
	dept_no varchar(5) references departments(dept_no)
);

-- create salaries table
CREATE TABLE salaries (
	emp_no varchar(10) references employees(emp_no),
	salary int
);
--Data Analysis
--1. List the employee number, last name, first name, sex, and salary of each employee.
SELECT emp.emp_no, emp.last_name, emp.first_name, emp.sex, sal.salary
FROM employees emp
JOIN salaries sal
ON emp.emp_no = sal.emp_no;

--2. List first name, last name, and hire date for employees who were hired in 1986.
SELECT first_name, last_name, hire_date 
FROM employees
WHERE hire_date BETWEEN '1986-1-1' and '1986-12-31'
ORDER BY hire_date ASC;

--3. List the manager of each department along with their department number, 
--department name, employee number, last name, and first name.
SELECT dm.dept_no, dept.dept_name, dm.emp_no, emp.last_name, emp.first_name 
FROM dept_manager dm
JOIN employees emp
ON dm.emp_no = emp.emp_no
JOIN departments dept
ON dm.dept_no = dept.dept_no
ORDER BY dept.dept_name ASC;

--4. List the department number for each employee along with that employee’s employee number,
--last name, first name, and department name.
SELECT emp.emp_no, emp.last_name, emp.first_name, dept.dept_name
FROM employees emp
JOIN dept_emp de 
ON emp.emp_no = de.emp_no
JOIN departments dept
ON dept.dept_no = de.dept_no
ORDER BY dept.dept_name ASC;

--5.List first name, last name, and sex of each employee whose first name is Hercules
--and whose last name begins with the letter B.
SELECT first_name, last_name, sex
FROM employees 
WHERE first_name = 'Hercules' AND last_name LIKE 'B%'
ORDER BY last_name ASC;

--6. List each employee in the Sales department, including their employee number, last name, and first name.
SELECT emp.emp_no, emp.last_name, emp.first_name, dept.dept_name
FROM employees emp
JOIN dept_emp de 
ON emp.emp_no = de.emp_no
JOIN departments dept
ON dept.dept_no = de.dept_no
WHERE dept.dept_name = 'Sales';

--7. List each employee in the Sales and Development departments, 
--including their employee number, last name, first name, and department name
SELECT emp.emp_no, emp.last_name, emp.first_name, dept.dept_name
FROM employees emp
JOIN dept_emp de 
ON emp.emp_no = de.emp_no
JOIN departments dept
ON dept.dept_no = de.dept_no
WHERE dept.dept_name = 'Sales' OR dept.dept_name = 'Development'
ORDER BY dept.dept_name ASC;

--8. List the frequency counts, in descending order, of all the employee last names
--(that is, how many employees share each last name)
SELECT last_name, count(emp_no) as same_last_name_emp
FROM employees
GROUP BY last_name
ORDER BY same_last_name_emp DESC;