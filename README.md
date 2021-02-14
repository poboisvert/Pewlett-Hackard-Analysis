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

Figure 1: PostgreSQL schema
<img src="https://github.com/poboisvert/Pewlett-Hackard-Analysis/blob/main/EmployeeDB.png?raw=true" width="750" />

### Step 2: additional tables

Following tables are created in order to have additional insights.

- retirement_titles (generate a list of retiring employees)
- unique_titles (Select the lasted job title for the employees in retirement_titles
- retiring_titles (Generate a count by job title from the list unique_titles)

## Summary

In this project to acheive the goal, we needed to create some other beneficial tables as well, which could be usefull anytime for the manager requests and help them current system analysis and decision making.

### Table 1: mentorship_eligibilty

This table give a list of 1,550 employees that fit into the "silver tsunami" and will reach soon the retirement age.

## Two additional querries

To complete and help to identify current employees, and gives informations about retirement based on current employees.

```
SELECT
	COUNT(me.emp_no),
	SUM(sa.salary)/COUNT(me.emp_no) AS "Average Salary",
	d.dept_name
FROM mentorship_eligibilty as me
INNER JOIN salaries AS sa
ON (me.emp_no = sa.emp_no)
INNER JOIN dept_emp AS de
ON (me.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dep_no = d.dept_no)
GROUP BY d.dept_no
ORDER BY COUNT(me.emp_no) DESC
```

```
SELECT
    me.emp_no,
    me.first_name,
    me.last_name,
    me.birth_date,
	me.from_date,
	me.title,
	sa.salary
FROM mentorship_eligibilty as me
INNER JOIN salaries AS sa
ON (me.emp_no = sa.emp_no)
WHERE me.from_date >= '19991231'
ORDER BY me.from_date DESC
```
