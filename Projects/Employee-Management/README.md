# SQL-Repo: Employee Management SQL Queries

This repository contains SQL queries for an **Employee Management System**. The queries demonstrate various SQL features such as ranking, data aggregation, and complex joins.

## Employee Table Structure
The `Employees` table has the following columns:
- `EmployeeID` (Primary Key)
- `Name`
- `Department`
- `Position`
- `Salary`
- `Performance_Score`
- `Years_of_Service`
- `Hire_Date`

## Sample Data
The table is populated with sample data for various departments such as Sales, IT, Marketing, and more.

## SQL Queries

### Question 1: Top Performers in Each Department
This query ranks employees within each department based on their performance score, returning the top 3 performers in each department.

### Question 2: Best Performers by Department
This query ranks employees within each department based on performance, showing the top performer of each department.

### Question 3: Employees with More Than 3 Years of Service
This query ranks employees with over 3 years of service, showing their performance scores.

### Question 4: Salary Comparison with Department Average
This query compares each employee's salary with the average salary of their department and ranks them accordingly.

### Question 5: Combined Ranking (Performance + Years of Service)
This query ranks employees based on a combined score of performance and years of service, with different weights assigned to each factor.

### Bonus Challenge
This query ranks the top performers who joined the company in the last 3 years, showing only the top 3 performers.
