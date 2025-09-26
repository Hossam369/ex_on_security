------------------------------------------------------------
-- 1. CREATE LOGINS
------------------------------------------------------------
CREATE LOGIN HOSSAM_SERVER WITH PASSWORD = '123456';
CREATE LOGIN AHMED_SERVER WITH PASSWORD = '123456';

------------------------------------------------------------
-- 2. CREATE USERS
------------------------------------------------------------
CREATE USER HALA FOR LOGIN HOSSAM_SERVER;
CREATE USER AHMED FOR LOGIN AHMED_SERVER;

------------------------------------------------------------
-- 3. GRANT PERMISSIONS
------------------------------------------------------------

-- HALA: READ ONLY
GRANT SELECT ON HR.Employees TO HALA;
GRANT SELECT ON HR.Departments TO HALA;
GRANT SELECT ON SALES.Customers TO HALA;
GRANT SELECT ON SALES.Orders TO HALA;
GRANT SELECT ON FINANCE.Expenses TO HALA;

-- AHMED: WRITE PERMISSIONS
GRANT INSERT ON HR.Employees TO AHMED;
GRANT INSERT ON HR.Departments TO AHMED;
GRANT INSERT ON SALES.Customers TO AHMED;
GRANT INSERT ON SALES.Orders TO AHMED;
GRANT INSERT ON FINANCE.Expenses TO AHMED;

------------------------------------------------------------
-- 4. REVOKE PERMISSIONS (if needed)
------------------------------------------------------------

-- HALA
REVOKE SELECT ON HR.Employees FROM HALA;
REVOKE SELECT ON HR.Departments FROM HALA;
REVOKE SELECT ON SALES.Customers FROM HALA;
REVOKE SELECT ON SALES.Orders FROM HALA;
REVOKE SELECT ON FINANCE.Expenses FROM HALA;

-- AHMED
REVOKE INSERT ON HR.Employees FROM AHMED;
REVOKE INSERT ON HR.Departments FROM AHMED;
REVOKE INSERT ON SALES.Customers FROM AHMED;
REVOKE INSERT ON SALES.Orders FROM AHMED;
REVOKE INSERT ON FINANCE.Expenses FROM AHMED;
