SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

-- Retirement eligibility 7.3.1
-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info;

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;

-- Joining departments and dept_manager tables 7.3.3
SELECT 
	departments.dept_name,
    dept_manager.emp_no,
    dept_manager.from_date,
	dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

-- Joining retirement_info and dept_emp tables
SELECT 
	retirement_info.emp_no,
    retirement_info.first_name,
	retirement_info.last_name,
    dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;

-- save as before but shorter
SELECT 
	ri.emp_no,
    ri.first_name,
	ri.last_name,
    de.to_date
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no;


SELECT 
	d.dept_name,
	dm.emp_no,
    dm.from_date,
    dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;

SELECT 
	ri.emp_no,
    ri.first_name,
    ri.last_name,
	de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dep_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dep_no 

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dep_no
INTO dep_count
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dep_no 
ORDER BY de.dep_no ASC;

SELECT * FROM dep_count

-- 7.3.5 
SELECT * FROM salaries;

SELECT * FROM salaries
ORDER BY to_date DESC;

SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info

SELECT 
	emp_no,
    first_name,
	last_name,
    gender
INTO emp_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM emp_info

SELECT 
	e.emp_no,
    e.first_name,
	e.last_name,
    e.gender,
    s.salary,
    de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01');

SELECT * FROM emp_info

-- List of managers per department
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
INTO manager_info
FROM dept_manager AS dm
    INNER JOIN departments AS d
        ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp AS ce
        ON (dm.emp_no = ce.emp_no);
		
SELECT * FROM manager_info

SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
-- INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dep_no = d.dept_no);

-- 7.3.6
SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
-- INTO dept_info
FROM employees as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dep_no = d.dept_no)
WHERE d.dept_name='Sales'

-- Sales andd DEl employee list
SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
-- INTO dept_info
FROM employees as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dep_no = d.dept_no)
WHERE d.dept_name IN ('Sales','Development')

-- Challenge BEGIN
-- Employee soon retired Aggregation START
SELECT 
    em.emp_no,
    em.first_name,
    em.last_name,
    ti.title,
    ti.from_date,
    ti.to_date
INTO retirement_titles
FROM employees as em
INNER JOIN titles AS ti
ON (em.emp_no = ti.emp_no)
WHERE em.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY em.emp_no ASC;
-- Employee soon retired Aggregation END
-- Employee soon retired Aggregation and duplicated removed START
SELECT 
    DISTINCT ON (rt.emp_no)
	rt.emp_no,
    rt.first_name,
    rt.last_name,
    rt.title
INTO unique_titles
FROM retirement_titles as rt
ORDER BY rt.emp_no ASC, rt.to_date DESC;
-- Employee soon retired Aggregation and duplicated removed END
-- COUNT employee by title soon retired START
SELECT 
	COUNT(emp_no),
	title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(emp_no) DESC
-- COUNT employee by title soon retired END
-- Challenge PART 2
--The Employees Eligible for the Mentorship Program START
SELECT 
	DISTINCT ON (em.emp_no)
    em.emp_no,
    em.first_name,
    em.last_name,
    em.birth_date,
	de.from_date,
	de.to_date,
	ti.title
INTO mentorship_eligibilty
FROM employees as em
INNER JOIN dept_emp AS de
ON (em.emp_no = de.emp_no)
INNER JOIN (SELECT DISTINCT emp_no, title FROM titles) AS ti
ON (em.emp_no = ti.emp_no)
WHERE em.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
AND (de.to_date = '9999-01-01')
ORDER BY em.emp_no ASC
-- SELECT * FROM titles
--The Employees Eligible for the Mentorship Program END
-- Challenge END
--
-- Group by job title employee that will retire soon
SELECT 
COUNT(e.emp_no), 
d.dept_name
FROM employees AS e
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dep_no = d.dept_no)
WHERE (de.to_date = '9999-01-01')
GROUP BY d.dept_no
ORDER BY COUNT(e.emp_no) DESC

-- Group by job title employee that will retire soon
SELECT 
	COUNT(ut.emp_no),
	SUM(sa.salary)/COUNT(ut.emp_no) AS "Average Salary",
	d.dept_name
FROM unique_titles as ut
INNER JOIN salaries AS sa
ON (ut.emp_no = sa.emp_no) 
INNER JOIN dept_emp AS de
ON (ut.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dep_no = d.dept_no)
GROUP BY d.dept_no
ORDER BY COUNT(ut.emp_no) DESC

