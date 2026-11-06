CREATE DATABASE company_db;

USE company_db;

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department_id INT,
    salary DECIMAL(10,2),
    hire_date DATE
);

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);


INSERT INTO departments VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance'),
(4, 'Marketing');

INSERT INTO employees VALUES
(101, 'Amit', 1, 60000, '2022-01-15'),
(102, 'Priya', 2, 45000, '2021-03-10'),
(103, 'Rahul', 1, 75000, '2020-07-20'),
(104, 'Sneha', 3, 55000, '2023-02-01'),
(105, 'Kiran', 2, 50000, '2022-06-12'),
(106, 'Neha', 3, 65000, '2021-11-05');


-- Display all employees
SELECT * FROM employees;

-- Find employees earning more than 50000
SELECT * FROM employees
WHERE salary > 50000;

-- Sort employees by salary
SELECT * FROM employees
ORDER BY salary DESC;

-- Find total employees
SELECT COUNT(*) FROM employees;

-- Find average salary
SELECT AVG(salary) FROM employees;

-- Department-wise salary
SELECT department_id, SUM(salary)
FROM employees
GROUP BY department_id;


SELECT e.emp_name, d.department_name
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id;


SELECT e.emp_name, d.department_name
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id;


SELECT e.emp_name, d.department_name
FROM employees e
RIGHT JOIN departments d
ON e.department_id = d.department_id;


SELECT *
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);


SELECT *
FROM employees
WHERE salary = (
    SELECT MAX(salary)
    FROM employees
);


SELECT
    emp_name,
    salary,
    ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_num
FROM employees;


SELECT
    emp_name,
    salary,
    RANK() OVER (ORDER BY salary DESC) AS salary_rank
FROM employees;


SELECT
    emp_name,
    salary,
    DENSE_RANK() OVER (ORDER BY salary DESC) AS dense_rank
FROM employees;


SELECT
    emp_name,
    department_id,
    salary,
    RANK() OVER (
        PARTITION BY department_id
        ORDER BY salary DESC
    ) AS dept_rank
FROM employees;


SELECT
    emp_name,
    salary,
    SUM(salary) OVER (
        ORDER BY emp_id
    ) AS running_total
FROM employees;


SELECT MAX(salary)
FROM employees
WHERE salary < (
    SELECT MAX(salary)
    FROM employees
);


SELECT *
FROM (
    SELECT
        emp_name,
        department_id,
        salary,
        ROW_NUMBER() OVER (
            PARTITION BY department_id
            ORDER BY salary DESC
        ) AS rn
    FROM employees
) ranked
WHERE rn = 1;


SELECT department_id, COUNT(*) AS employee_count
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 1;