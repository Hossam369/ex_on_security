------------------------------------------------------------
-- DATABASE & SCHEMAS INITIALIZATION
------------------------------------------------------------

-- 1. CREATE DATABASE
CREATE DATABASE GUEST;
GO

USE GUEST;
GO

-- 2. CREATE SCHEMAS
CREATE SCHEMA SALES;
GO

CREATE SCHEMA FINANCE;
GO

CREATE SCHEMA HR;
GO


------------------------------------------------------------
-- TABLES CREATION
------------------------------------------------------------

-- HR Schema
CREATE TABLE HR.Departments (
    DepartmentID INT PRIMARY KEY IDENTITY(1,1),
    DepartmentName NVARCHAR(100)
);

CREATE TABLE HR.Employees (
    EmpID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Position NVARCHAR(50),
    HireDate DATE,
    DepartmentID INT
);

-- FINANCE Schema
CREATE TABLE FINANCE.Salaries (
    EmpID INT,
    Salary DECIMAL(10,2),
    PayDate DATE,
    PRIMARY KEY (EmpID, PayDate)
);

CREATE TABLE FINANCE.Expenses (
    ExpenseID INT PRIMARY KEY IDENTITY(1,1),
    ExpenseType NVARCHAR(100),
    Amount DECIMAL(10,2),
    ExpenseDate DATE
);

-- SALES Schema
CREATE TABLE SALES.Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    CustomerName NVARCHAR(100),
    Email NVARCHAR(100),
    Phone NVARCHAR(20)
);

CREATE TABLE SALES.Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES SALES.Customers(CustomerID)
);


------------------------------------------------------------
-- INSERT INITIAL DATA
------------------------------------------------------------

-- Departments
INSERT INTO HR.Departments (DepartmentName)
VALUES 
('Human Resources'),
('Finance'),
('Sales'),
('IT Support');

-- Employees
INSERT INTO HR.Employees (FirstName, LastName, Position, HireDate, DepartmentID)
VALUES
('Ali', 'Hassan', 'HR Manager', '2020-05-01', 1),
('Mona', 'Ibrahim', 'Accountant', '2021-03-15', 2),
('Omar', 'Khaled', 'Sales Rep', '2022-01-10', 3),
('Sara', 'Nabil', 'IT Specialist', '2019-07-20', 4);

-- Salaries
INSERT INTO FINANCE.Salaries (EmpID, Salary, PayDate)
VALUES
(1, 12000, '2023-09-01'),
(2, 10000, '2023-09-01'),
(3, 8000,  '2023-09-01'),
(4, 9500,  '2023-09-01');

-- Expenses
INSERT INTO FINANCE.Expenses (ExpenseType, Amount, ExpenseDate)
VALUES
('Office Rent', 5000, '2023-09-05'),
('Utilities', 1200, '2023-09-07'),
('Stationery', 600, '2023-09-10');

-- Customers
INSERT INTO SALES.Customers (CustomerName, Email, Phone)
VALUES
('Ahmed Ali', 'ahmed.ali@email.com', '01012345678'),
('Fatma Saeed', 'fatma.saeed@email.com', '01087654321'),
('Khaled Omar', 'khaled.omar@email.com', '01123456789');

-- Orders
INSERT INTO SALES.Orders (CustomerID, OrderDate, TotalAmount)
VALUES
(1, '2023-09-12', 1500.50),
(2, '2023-09-13', 2500.00),
(3, '2023-09-14', 900.75);


------------------------------------------------------------
-- CREATE LOGINS & USERS
------------------------------------------------------------

-- Logins
CREATE LOGIN HOSSAM_SERVER  WITH PASSWORD = '123456';
CREATE LOGIN AHMED_SERVER   WITH PASSWORD = '123456';
CREATE LOGIN MOHAMED_SERVER WITH PASSWORD = '123456';

-- Users
CREATE USER HALA   FOR LOGIN HOSSAM_SERVER;
CREATE USER AHMED  FOR LOGIN AHMED_SERVER;
CREATE USER HOSSAM FOR LOGIN MOHAMED_SERVER;


------------------------------------------------------------
-- GRANT PERMISSIONS
------------------------------------------------------------

-- HALA: Read-only access
GRANT SELECT ON HR.Employees   TO HALA;
GRANT SELECT ON HR.Departments TO HALA;
GRANT SELECT ON SALES.Customers TO HALA;
GRANT SELECT ON SALES.Orders    TO HALA;
GRANT SELECT ON FINANCE.Expenses TO HALA;
GRANT SELECT ON FINANCE.Salaries TO HALA;

-- AHMED: Write access
GRANT INSERT ON HR.Employees   TO AHMED;
GRANT INSERT ON HR.Departments TO AHMED;
GRANT INSERT ON SALES.Customers TO AHMED;
GRANT INSERT ON SALES.Orders    TO AHMED;
GRANT INSERT ON FINANCE.Expenses TO AHMED;
GRANT SELECT ON FINANCE.Salaries TO AHMED;

-- HOSSAM: Update access
GRANT UPDATE ON HR.Employees   TO HOSSAM;
GRANT UPDATE ON HR.Departments TO HOSSAM;
GRANT UPDATE ON SALES.Customers TO HOSSAM;
GRANT UPDATE ON SALES.Orders    TO HOSSAM;
GRANT UPDATE ON FINANCE.Expenses TO HOSSAM;
GRANT UPDATE ON FINANCE.Salaries TO HOSSAM;


------------------------------------------------------------
-- OPTIONAL: REVOKE PERMISSIONS
------------------------------------------------------------

-- HALA
REVOKE SELECT ON HR.Employees   FROM HALA;
REVOKE SELECT ON HR.Departments FROM HALA;
REVOKE SELECT ON SALES.Customers FROM HALA;
REVOKE SELECT ON SALES.Orders    FROM HALA;
REVOKE SELECT ON FINANCE.Expenses FROM HALA;

-- AHMED
REVOKE INSERT ON HR.Employees   FROM AHMED;
REVOKE INSERT ON HR.Departments FROM AHMED;
REVOKE INSERT ON SALES.Customers FROM AHMED;
REVOKE INSERT ON SALES.Orders    FROM AHMED;
REVOKE INSERT ON FINANCE.Expenses FROM AHMED;

-- HOSSAM
REVOKE UPDATE ON HR.Employees   FROM HOSSAM;
REVOKE UPDATE ON HR.Departments FROM HOSSAM;
REVOKE UPDATE ON SALES.Customers FROM HOSSAM;
REVOKE UPDATE ON SALES.Orders    FROM HOSSAM;
REVOKE UPDATE ON FINANCE.Expenses FROM HOSSAM;
REVOKE UPDATE ON FINANCE.Salaries FROM HOSSAM;


------------------------------------------------------------
-- VERIFY DATA (OPTIONAL)
------------------------------------------------------------
SELECT * FROM HR.Departments;
SELECT * FROM HR.Employees;
SELECT * FROM FINANCE.Salaries;
SELECT * FROM FINANCE.Expenses;
SELECT * FROM SALES.Customers;
SELECT * FROM SALES.Orders;
