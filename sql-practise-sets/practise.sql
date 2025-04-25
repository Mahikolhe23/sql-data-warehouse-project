USE Practise_db
GO

--🔹 Basic SQL Questions
--How do you retrieve all columns and rows from the EMPLOYEE table?
SELECT * FROM Emp WHERE job_id = 'AC_ACCOUNT'

--How can you find unique job roles from the JOB_ID column?
SELECT DISTINCT job_id FROM EMP

--How would you list employees who joined in a specific year (e.g., 2023)?
SELECT * FROM Emp WHERE YEAR(CAST(HIRE_DATE AS DATE)) = 2007

--How do you extract just the first name, last name, and email of all employees?
SELECT FIRST_NAME,last_name,email FROM emp

--How would you filter employees based on DEPARTMENT_ID?
SELECT * FROM emp where department_id = 50

--🔹 Filtering, Sorting & Conditions
--How can you find employees with a salary above a specific amount?
SELECT * FROM emp WHERE salary > 500

--How do you sort employees by HIRE_DATE in descending order?
SELECT * FROM emp ORDER BY HIRE_DATE DESC

--How do you filter employees who don’t have a manager (MANAGER_ID is NULL)?
SELECT * FROM EMP WHERE manager_id IS NULL

--🔹 Aggregate Functions & Grouping
--How do you calculate the average salary of all employees
SELECT AVG(salary) FROM EMP

--How would you count the number of employees in each department?
SELECT COUNT(EMPLOYEE_ID) AS number_of_emp, department_id FROM EMP GROUP BY department_id

--How do you find the total salary paid in each JOB_ID?
SELECT SUM(salary)As total_salary,Job_id FROM EMP GROUP BY job_id

--How do you find departments with more than 5 employees?
SELECT COUNT(EMPLOYEE_ID)As total_emp, department_id FROM EMP GROUP BY department_id HAVING COUNT(EMPLOYEE_ID)> 5

--How would you get the maximum and minimum salary per job?
SELECT job_id, MAX(salary) as max_sal, MIN(salary) as min_sal FROM emp GROUP BY job_id

--🔹 Joins & Subqueries
--How would you find employees whose salary is greater than the average salary?
SELECT * FROM EMP WHERE salary > (SELECT AVG(salary) FROM Emp)

--How do you fetch details of the highest-paid employee?
SELECT TOP 1 * FROM emp ORDER BY salary DESC;

with cte as (SELECT *, ROW_NUMBER() OVER(ORDER BY salary DESC) AS salary_rnk FROM EMP) 
SELECT * FROM cte WHERE salary_rnk = 1

--What is a correlated subquery, and how would you use it with this table?
SELECT * FROM emp e WHERE salary > (SELECT AVG(salary) FROM EMP e2 WHERE e2.department_id = e.department_id)

--How would you display manager and their direct reports using a self-join?
SELECT e1.FIRST_NAME AS manager, e2.FIRST_NAME as reporting_emp FROM Emp e1 INNER JOIN Emp e2 ON e1.EMPLOYEE_ID = e2.MANAGER_ID

-- 🔹 Date Functions & String Operations
-- How do you extract only the year or month from the HIRE_DATE column?
SELECT YEAR(hire_date),MONTH(hire_date) FROM Emp

-- How do you calculate the number of years/months an employee has worked?
SELECT EMPLOYEE_ID , datediff(YEAR,HIRE_DATE,GETDATE()) AS exp_yrs FROM Emp

-- How would you concatenate FIRST_NAME and LAST_NAME as a full name?
SELECT FIRST_NAME + ' ' + LAST_NAME FROM Emp

-- How do you filter employees based on partial match in EMAIL (e.g., emails ending with "gmail.com")?
SELECT * FROM Emp WHERE EMAIL LIKE '%gmail.com'

-- How would you replace null values in COMMISSION_PCT with '0%'?
SELECT EMPLOYEE_ID, REPLACE(COMMISSION_PCT,'-','0%') FROM Emp

-- 🔹 Advanced & Scenario-Based
-- How do you identify duplicate email addresses in the table?
SELECT COUNT(email) FROM Emp GROUP BY EMAIL HAVING COUNT(EMAIL) > 1

-- How would you get top 3 highest salaried employees per department?
WITH CTE AS (SELECT *,
ROW_NUMBER() OVER(PARTITION BY department_id ORDER BY salary DESC) AS salary_rnk
FROM Emp)
SELECT * FROM CTE WHERE salary_rnk < 4

-- How would you handle missing or invalid HIRE_DATE values in your queries?
SELECT FIRST_NAME,LAST_NAME,COALESCE(HIRE_DATE,CAST('2020-01-01' AS DATE)) FROM Emp

-- What indexes would you create on this table for performance improvement?
CREATE INDEX idx_emp_emp_id ON emp(EMPLOYEE_ID)

-- Alternate way using FETCH (SQL Server 2012+)
SELECT * FROM emp ORDER BY salary DESC OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY;

-- 🔹 Advanced SQL Questions for Practice
-- Find employees who earn more than the average salary of their department and also joined after 2020.
SELECT * FROM Emp WHERE YEAR(CAST(HIRE_DATE AS DATE)) > 2006 AND SALARY > (SELECT AVG(SALARY) FROM Emp)

-- Get the second highest salary for each department.
WITH CTE AS ( SELECT *, DENSE_RANK() OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY DESC) AS salary_rnk FROM Emp)
SELECT c1.DEPARTMENT_ID, c1.SALARY AS second_highest_salary
FROM CTE c1
LEFT JOIN CTE c2 ON c1.DEPARTMENT_ID = c2.DEPARTMENT_ID AND c2.salary_rnk = 2
WHERE c1.salary_rnk = 1

-- List all employees who have the same salary as at least one other employee.
SELECT DISTINCT e1.* FROM Emp e1
INNER JOIN Emp e2 ON e1.SALARY = e2.SALARY
WHERE e1.EMPLOYEE_ID != e2.EMPLOYEE_ID

-- Find the department with the highest total salary expense.
SELECT TOP 1 DEPARTMENT_ID, SUM(SALARY) FROM Emp GROUP BY DEPARTMENT_ID ORDER BY SUM(SALARY) DESC

-- Identify employees who have never reported to a manager (excluding NULLs).
SELECT * FROM Emp WHERE MANAGER_ID = ' - '

-- Get all employees whose HIRE_DATE is the latest in their department.
WITH CTE AS (SELECT *,
RANK() OVER(PARTITION BY DEPARTMENT_ID ORDER BY HIRE_DATE DESC) AS latest_hire
FROM Emp)
SELECT * FROM CTE WHERE latest_hire = 1

-- List departments where the average salary is more than the overall company average salary.
SELECT * FROM Emp WHERE SALARY > (SELECT AVG(SALARY) FROM EMP)

-- List employees whose salary is within ±10% of their manager’s salary.
SELECT * FROM Emp e1 
JOIN Emp e2 ON e1.MANAGER_ID = e2.EMPLOYEE_ID
WHERE e1.SALARY BETWEEN e2.SALARY * 0.9 AND e2.SALARY * 1.1

-- Get the count of employees hired in each year and month (e.g., 2023-Jan).
SELECT COUNT(*) hire_numbers, SUBSTRING(HIRE_DATE,3,6) as month FROM EMP GROUP BY SUBSTRING(HIRE_DATE,3,6)

-- Display a ranking of employees within each department based on salary using DENSE_RANK.

-- List employees who joined on the same date as someone else.

-- Show department-wise max, min, and average salary along with number of employees.

-- Find all managers who have more than 3 direct reports.

-- Retrieve details of employees who have the same first name as any other employee.

-- Get all employees whose first or last name contains at least two consecutive vowels.

-- Create a comma-separated list of employees for each department (using STRING_AGG).

-- Identify the department with the maximum number of new joiners in the last 2 years.

-- Find employees who are getting commission, but their commission is more than 10% of their salary.

-- Determine the difference in salary between each employee and their manager.

-- List employees whose email username (before @) matches their first or last name.
SELECT * from #emp
SELECT * from #dept

SELECT * FROM #emp e
join #dept d ON e.emp_id = d.emp_id 
where  e.city = 'pune'



