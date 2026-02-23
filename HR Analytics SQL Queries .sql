HR Analytics SQL Queries


Database: hr_analytics

USE hr_analytics;

-- Query 1: Basic Data Check
SELECT * FROM employee_data LIMIT 10;

-- Query 2: Attrition Rate by Department
SELECT Department,
       COUNT(*) AS TotalEmployees,
       SUM(AttritionFlag) AS TotalAttrition,
       ROUND(SUM(AttritionFlag)/COUNT(*)*100, 2) AS AttritionRate
FROM employee_data
GROUP BY Department
ORDER BY AttritionRate DESC;

-- Query 3: Average Salary by Job Role
SELECT JobRole,
       ROUND(AVG(MonthlyIncome), 2) AS AvgSalary,
       MIN(MonthlyIncome) AS MinSalary,
       MAX(MonthlyIncome) AS MaxSalary
FROM employee_data
GROUP BY JobRole
ORDER BY AvgSalary DESC;

-- Query 4: Attrition by OverTime
SELECT OverTime,
       COUNT(*) AS TotalEmployees,
       SUM(AttritionFlag) AS Attrition,
       ROUND(SUM(AttritionFlag)/COUNT(*)*100, 2) AS AttritionRate
FROM employee_data
GROUP BY OverTime;

-- Query 5: Gender Distribution
SELECT Gender,
       COUNT(*) AS TotalEmployees,
       ROUND(COUNT(*)/200*100, 2) AS Percentage
FROM employee_data
GROUP BY Gender;

-- Query 6: Window Function - Salary Rank by Department
SELECT EmployeeID, Department, JobRole, MonthlyIncome,
       RANK() OVER(PARTITION BY Department 
       ORDER BY MonthlyIncome DESC) AS SalaryRank
FROM employee_data;

-- Query 7: CTE - High Risk Attrition Employees
WITH HighRisk AS (
    SELECT EmployeeID, Department, JobRole,
           MonthlyIncome, OverTime, YearsAtCompany
    FROM employee_data
    WHERE Attrition = 'Yes'
)
SELECT Department,
       COUNT(*) AS AttritionCount,
       ROUND(AVG(MonthlyIncome), 2) AS AvgSalary
FROM HighRisk
GROUP BY Department
ORDER BY AttritionCount DESC;

-- Query 8: Job Satisfaction Analysis
SELECT Department,
       ROUND(AVG(JobSatisfaction), 2) AS AvgSatisfaction,
       ROUND(AVG(WorkLifeBalance), 2) AS AvgWorkLifeBalance,
       ROUND(AVG(PerformanceRating), 2) AS AvgPerformance
FROM employee_data
GROUP BY Department
ORDER BY AvgSatisfaction DESC;