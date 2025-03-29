CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(30),
    Position VARCHAR(30),
    Salary DECIMAL(10,2),
    Performance_Score INT,
    Years_of_Service INT,
    Hire_Date DATE
);

-- Insert Sample Data
INSERT INTO Employees VALUES 
(1, 'John Smith', 'Sales', 'Representative', 55000.00, 85, 3, '2020-06-15'),
(2, 'Emily Johnson', 'Marketing', 'Manager', 75000.00, 92, 5, '2018-03-22'),
(3, 'Michael Chen', 'IT', 'Developer', 65000.00, 88, 4, '2019-11-10'),
(4, 'Sarah Rodriguez', 'Sales', 'Senior Representative', 60000.00, 90, 4, '2019-07-01'),
(5, 'David Kim', 'IT', 'Senior Developer', 70000.00, 95, 6, '2017-09-05'),
(6, 'Rachel Wong', 'Marketing', 'Specialist', 58000.00, 86, 3, '2020-01-15'),
(7, 'Alex Turner', 'Sales', 'Manager', 80000.00, 93, 5, '2018-05-20'),
(8, 'Emma Watson', 'HR', 'Coordinator', 52000.00, 82, 2, '2021-02-10'),
(9, 'Ryan Garcia', 'IT', 'Junior Developer', 55000.00, 80, 2, '2021-04-01'),
(10, 'Lisa Chen', 'Finance', 'Analyst', 62000.00, 87, 4, '2019-08-15');

select * from employees;

select distinct department from Employees;

-- Question 1: Write a query to find the top 3 performers in each department using DENSE_RANK().

WITH RankedEmployee AS (
    SELECT 
        *, 
        DENSE_RANK() OVER (
            PARTITION BY Department 
            ORDER BY Performance_Score DESC
        ) AS EmployeeRank
    FROM Employees
)
SELECT * 
FROM RankedEmployee 
WHERE EmployeeRank <= 3
ORDER BY Department, EmployeeRank;


-- Question 2: Create a query that ranks employees based on their performance score, showing their department's overall ranking.

WITH DepartmentRanking AS (
    SELECT 
        Name, 
        Department, 
        Position, 
        Performance_Score, 
        DENSE_RANK() OVER (
            PARTITION BY Department 
            ORDER BY Performance_Score DESC
        ) AS BestPerformerEmployee
    FROM Employees
)
SELECT Name, Department, Position, Performance_Score 
FROM DepartmentRanking 
WHERE BestPerformerEmployee = 1
ORDER BY Department;

-- Question 3: Develop a query to identify employees who have been in the company for more than 3 years and rank them by their performance score.

SELECT 
	EmployeeID, 
    Name, 
    Department, 
    Performance_Score, 
    Years_of_Service,
    DENSE_RANK() OVER (ORDER BY Performance_Score DESC)  AS PerformanceRank
FROM Employees
WHERE Years_of_Service > 3
order by PerformanceRank;
    
-- Question 4: Write a query to compare an employee's salary with the average salary of their department, and rank them accordingly.

SELECT 
    EmployeeID, 
    Name, 
    Department, 
    Salary, 
    AVG(Salary) OVER (PARTITION BY Department) AS Avg_Department_Salary,
    DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS SalaryRank
FROM Employees
ORDER BY Department, SalaryRank;


-- Question 5: Create a complex query that ranks employees based on a combined score of performance and years of service, with different weights for each factor.

SELECT 
    EmployeeID, 
    Name, 
    Department, 
    Performance_Score, 
    Years_of_Service, 
    (Performance_Score * 0.7 + Years_of_Service * 0.3) AS WeightedScore,
    DENSE_RANK() OVER (ORDER BY (Performance_Score * 0.7 + Years_of_Service * 0.3) DESC) AS Rnk
FROM Employees
ORDER BY Rnk;


-- Bonus Challenge: Design a query that finds the top performers who joined the company in the last 3 years, ranking them across all departments.

WITH RecentTopPerformers AS (
    SELECT 
        EmployeeID, 
        Name, 
        Department, 
        Performance_Score, 
        Hire_Date,
        DENSE_RANK() OVER (
            ORDER BY Performance_Score DESC
        ) AS PerformanceRank
    FROM Employees
    WHERE Hire_Date >= '2021-03-28'
)
SELECT *
FROM RecentTopPerformers
WHERE PerformanceRank <= 3
ORDER BY PerformanceRank;


