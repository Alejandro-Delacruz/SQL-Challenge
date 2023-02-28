/*List the employee number, last name, first name, sex,
and salary of each employee (2 points)*/

SELECT		s.emp_no,last_name,first_name,sex,salary 
FROM 		employees e
LEFT JOIN 	salaries s
ON 			e.emp_no=s.emp_no;

/*List the first name, last name, and hire date for the 
employees who were hired in 1986 (2 points)*/

SELECT 		first_name,last_name, hire_date 
FROM 		employees
WHERE EXTRACT(YEAR FROM hire_date)=1986;

/*List the manager of each department along with their department number, 
department name, employee number, last name, and first name (2 points)*/

SELECT a.dept_no,emp_no,first_name,last_name,dept_name FROM 
(SELECT d.dept_no, d.emp_no,first_name,last_name FROM dept_manager d
LEFT JOIN employees e
ON d.emp_no = e.emp_no) a
LEFT JOIN departments d2
ON a.dept_no=d2.dept_no;

/*List the department number for each employee along with that employee’s
employee number, last name, first name, and department name (2 points)*/

with emp_dept AS(
SELECT temp.dept_no,emp_no,last_name,first_name, dept_name FROM
(SELECT e.emp_no,last_name,first_name,dept_no FROM employees e
LEFT JOIN dept_emp d1
ON e.emp_no=d1.emp_no) temp
LEFT JOIN departments d2
ON temp.dept_no = d2.dept_no)

SELECT 	* 
FROM 	emp_dept;

/*List first name, last name, and sex of each employee whose first name 
is Hercules and whose last name begins with the letter B (2 points)*/

SELECT		first_name,last_name,sex
FROM		employees
WHERE		first_name='Hercules' AND SUBSTRING(last_name,1,1)='B';

/*
List each employee in the Sales department, 
including their employee number, last name, and first name (2 points)
*/

with emp_dept AS(
SELECT temp.dept_no,emp_no,last_name,first_name, dept_name FROM
(SELECT e.emp_no,last_name,first_name,dept_no FROM employees e
LEFT JOIN dept_emp d1
ON e.emp_no=d1.emp_no) temp
LEFT JOIN departments d2
ON temp.dept_no = d2.dept_no)
SELECT emp_no,last_name, first_name,dept_name
FROM emp_dept
WHERE dept_name='Sales';

/*List each employee in the Sales and Development departments, 
including their employee number, last name, first name, and department name (4 points)*/

with emp_dept AS(
SELECT temp.dept_no,emp_no,last_name,first_name, dept_name FROM
(SELECT e.emp_no,last_name,first_name,dept_no FROM employees e
LEFT JOIN dept_emp d1
ON e.emp_no=d1.emp_no) temp
LEFT JOIN departments d2
ON temp.dept_no = d2.dept_no)
SELECT emp_no,last_name, first_name,dept_name
FROM emp_dept
WHERE dept_name='Sales' OR dept_name='Development';

/*List the frequency counts, in descending order, 
of all the employee last names (that is, how many employees share each last name) (4 points)*/

SELECT 		last_name,COUNT(first_name) AS frequency
FROM 		employees
GROUP BY 	last_name
ORDER BY 	frequency desc;
