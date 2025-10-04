------------------------------------------------------------
-- DATABASE & SCHEMAS INITIALIZATION
------------------------------------------------------------

-- 1. CREATE DATABASE
CREATE DATABASE GUEST_TEST;
GO

USE GUEST_TEST;
GO

-- 2. CREATE SCHEMAS
CREATE SCHEMA SALES;
GO

CREATE SCHEMA FINANCE;
GO

CREATE SCHEMA HR;
GO


------------------------------------------------------------
--  TABLES CREATION
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
--  INSERT INITIAL DATA
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
('HANAA Ali', 'HANAA.ali@email.com', '01012345678'),
('Fatma Saeed', 'fatma.saeed@email.com', '01087654321'),
('Khaled Omar', 'khaled.omar@email.com', '01123456789');

-- Orders
INSERT INTO SALES.Orders (CustomerID, OrderDate, TotalAmount)
VALUES
(1, '2023-09-12', 1500.50),
(2, '2023-09-13', 2500.00),
(3, '2023-09-14', 900.75);


------------------------------------------------------------
--  CREATE LOGINS & USERS
------------------------------------------------------------

-- Logins
CREATE LOGIN HALA_SERVER   WITH PASSWORD = '123456';
CREATE LOGIN HANAA_SERVER  WITH PASSWORD = '123456';
CREATE LOGIN ASMAA_SERVER  WITH PASSWORD = '123456';

-- Users
CREATE USER HALA   FOR LOGIN HALA_SERVER;
CREATE USER HANAA  FOR LOGIN HANAA_SERVER;
CREATE USER ASMAA  FOR LOGIN ASMAA_SERVER;


------------------------------------------------------------
-- 📌 GRANT PERMISSIONS
------------------------------------------------------------

-- HALA: Read-only access
GRANT SELECT ON HR.Employees     TO HALA;
GRANT SELECT ON HR.Departments   TO HALA;
GRANT SELECT ON SALES.Customers  TO HALA;
GRANT SELECT ON SALES.Orders     TO HALA;
GRANT SELECT ON FINANCE.Expenses TO HALA;
GRANT SELECT ON FINANCE.Salaries TO HALA;

-- HANAA: Write (INSERT + SELECT salaries)
GRANT INSERT ON HR.Employees     TO HANAA;
GRANT INSERT ON HR.Departments   TO HANAA;
GRANT INSERT ON SALES.Customers  TO HANAA;
GRANT INSERT ON SALES.Orders     TO HANAA;
GRANT INSERT ON FINANCE.Expenses TO HANAA;
GRANT SELECT ON FINANCE.Salaries TO HANAA;


------------------------------------------------------------
--  CREATE STORED PROCEDURES FOR UPDATES (ASMAA)
------------------------------------------------------------

-- HR
CREATE PROCEDURE HR.UpdateEmployeePosition
    @EmpID INT,
    @NewPosition NVARCHAR(50)
AS
BEGIN
    UPDATE HR.Employees
    SET Position = @NewPosition
    WHERE EmpID = @EmpID;
END;
GO

CREATE PROCEDURE HR.UpdateDepartmentName
    @DepartmentID INT,
    @NewName NVARCHAR(100)
AS
BEGIN
    UPDATE HR.Departments
    SET DepartmentName = @NewName
    WHERE DepartmentID = @DepartmentID;
END;
GO

-- SALES
CREATE PROCEDURE SALES.UpdateCustomer
    @CustomerID INT,
    @NewEmail NVARCHAR(100),
    @NewPhone NVARCHAR(20)
AS
BEGIN
    UPDATE SALES.Customers
    SET Email = @NewEmail,
        Phone = @NewPhone
    WHERE CustomerID = @CustomerID;
END;
GO

CREATE PROCEDURE SALES.UpdateOrderAmount
    @OrderID INT,
    @NewAmount DECIMAL(10,2)
AS
BEGIN
    UPDATE SALES.Orders
    SET TotalAmount = @NewAmount
    WHERE OrderID = @OrderID;
END;
GO

-- FINANCE
CREATE PROCEDURE FINANCE.UpdateExpense
    @ExpenseID INT,
    @NewAmount DECIMAL(10,2)
AS
BEGIN
    UPDATE FINANCE.Expenses
    SET Amount = @NewAmount
    WHERE ExpenseID = @ExpenseID;
END;
GO

CREATE PROCEDURE FINANCE.UpdateSalary
    @EmpID INT,
    @PayDate DATE,
    @NewSalary DECIMAL(10,2)
AS
BEGIN
    UPDATE FINANCE.Salaries
    SET Salary = @NewSalary
    WHERE EmpID = @EmpID AND PayDate = @PayDate;
END;
GO


------------------------------------------------------------
--  GRANT EXECUTE TO ASMAA (ONLY ON PROCEDURES)
------------------------------------------------------------
GRANT EXECUTE ON HR.UpdateEmployeePosition  TO ASMAA;
GRANT EXECUTE ON HR.UpdateDepartmentName    TO ASMAA;
GRANT EXECUTE ON SALES.UpdateCustomer       TO ASMAA;
GRANT EXECUTE ON SALES.UpdateOrderAmount    TO ASMAA;
GRANT EXECUTE ON FINANCE.UpdateExpense      TO ASMAA;
GRANT EXECUTE ON FINANCE.UpdateSalary       TO ASMAA;
