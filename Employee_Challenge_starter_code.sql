-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (______) _____,
______,
______,
______

INTO nameyourtable
FROM _______
ORDER BY _____, _____ DESC;

-- INTO dept_info
SELECT 
    em.emp_no,
    em.first_name,
    em.last_name,
    t.title,
    t.from_date,
    t.to_date
FROM employees as em
INNER JOIN titles AS t
ON (em.emp_no = t.emp_no)
FROM employees as em
WHERE em.birth_date BETWEEN '1952-01-01' AND '1955-12-31';