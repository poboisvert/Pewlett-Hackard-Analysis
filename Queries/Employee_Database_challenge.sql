-- Deliverable 1: The Number of Retiring Employees of each title category START (0 - 7)
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
-- Querie test below
--
-- SELECT * FROM retirement_titles ;
--
-- Deliverable 1: The Number of Retiring Employees of each title category END
-- Employee soon retired Aggregation and duplicated removed START (8 - 15)
SELECT 
    DISTINCT ON (rt.emp_no)
	rt.emp_no,
    rt.first_name,
    rt.last_name,
    rt.title
INTO unique_titles
FROM retirement_titles as rt
ORDER BY rt.emp_no ASC, rt.to_date DESC;
-- Employee soon retired Aggregation and duplicated removed START (8 - 15) END
-- COUNT employee by title soon retired (15 - 21) START
SELECT 
	COUNT(emp_no),
	title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(emp_no) DESC
-- COUNT employee by title soon retired (15 - 21) END
-- Challenge PART 2
-- The Employees Eligible for the Mentorship Program START
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
-- Querie test below
--
-- SELECT * FROM titles
-- 
--The Employees Eligible for the Mentorship Program END
-- Group by job title employee that will retire soon
SELECT 
	COUNT(rt.emp_no),
    rt.title
FROM retirement_titles as rt
GROUP BY rt.title
ORDER BY COUNT(rt.emp_no) DESC
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



