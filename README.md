## Project Overview

The purpose of this project is to investigate and find recommendation in a list of 300,024 number of employees working at Pewlett Hackard. We want to (1) identify the ones that are eligible for retirement, (2) and the ones that are in the list of eligibility of mentorship. We complete the analysis, we imported and created a PostgreSQL database with queries in order to generate report that have been exported to CSV files.

## Resources

Datasets (Data folder): departments.csv, dept_emp.csv, dept_manager.csv, employees.csv, salaries.csv, titles.csv, retirement_info.csv
Software: PostgreSQL 11.10 and QuickDBD (https://www.quickdatabasediagrams.com/)

## Results

We the help of SQL in pgAdmin4, querries are written and the results are as listed below:

- mentorship_eligibility
- retirement_titles
- retiring_titles
- unique_titles

### Step 1: Database Schema & importation

#### Figure 1: PostgreSQL schema

<img src="https://github.com/poboisvert/Pewlett-Hackard-Analysis/blob/main/Data/img/EmployeeDB.png?raw=true" width="750" />

### Step 2: additional tables

Following tables are created in order to have additional insights.

- retirement_titles (generate a list of retiring employees)
- unique_titles (Select the lasted job title for the employees in retirement_titles
- retiring_titles (Generate a count by job title from the list unique_titles)

## Summary

### Eligible for retirement

The list to generate the employees that may retire soon must be respect these two criterias: (1) WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') and
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31').

The summary is 90,398 employees will be soon retired from the company if we consider the data from the table "unique_title" and we currently have 240,124 total employees that are still active in the database.

### Employees Eligible for the Mentorship Program

In this project to acheive the goal, we needed to create some other beneficial tables as well, which could be usefull anytime for the manager requests and help them current system analysis and decision making.

### Table 1: mentorship_eligibilty

This table give a list of 1,549 employees that fit into the mentorship eligibility and will reach soon the retirement age. By category, we have 78 are Assistant Manager, 155 Staff, 569 are Senior Staff, 501 Engineer and 169 Senior Engineer.

### Two additional querries

To complete and help to identify current employees, and gives informations about retirement based on current employees.

#### Figure 2: Ready to retire by job title

<img src="https://github.com/poboisvert/Pewlett-Hackard-Analysis/blob/main/Data/img/Recent_employees.png" width="750" />

This figure illustrate the weight of each department in order to help us see which departement are intense in labor. Development, production and sales are the most intensive and Finance is the least. Below is the snippet for the additional query.

```
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
```

#### Figure 3: Ready to retire by job title

<img src="https://github.com/poboisvert/Pewlett-Hackard-Analysis/blob/main/Data/img/Group_department.png" width="750" />

The figure three illustrate the most impacted departement by the retirement and must consider the long term company strategy. The average salary is higher for the Finance and Marketing department and the company must address if the replacement cost will be lower. Since finance is the smallest department and where the average salary is higher, it will be important to hire highly qualified employee. Below is the snippet for the additional query.

```
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
```
