------------------------------------------------------------
-- 1. CREATE TABLES
------------------------------------------------------------

-- HR Schema
CREATE TABLE HR.Employees (
    EmpID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Position NVARCHAR(50),
    HireDate DATE,
    DepartmentID INT
);

CREATE TABLE HR.Departments (
    DepartmentID INT PRIMARY KEY IDENTITY(1,1),
    DepartmentName NVARCHAR(100)
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
-- 2. INSERT VALUES
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
-- Optional: SELECT TO VERIFY
------------------------------------------------------------
SELECT * FROM HR.Departments;
SELECT * FROM HR.Employees;
SELECT * FROM FINANCE.Salaries;
SELECT * FROM FINANCE.Expenses;
SELECT * FROM SALES.Customers;
SELECT * FROM SALES.Orders;
