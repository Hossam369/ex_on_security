# GUEST_TEST Database Project

## 📌 Overview
This project contains a sample SQL Server database (`GUEST_TEST`) with three main schemas:
- **HR**: Departments & Employees  
- **SALES**: Customers & Orders  
- **FINANCE**: Salaries & Expenses  

The database includes:
- Sample data for testing  
- Logins and Users with different roles  
- Stored Procedures for updating data  

---

## 👤 Users & Roles

### 1. **HALA** (Login: `HALA_SERVER`)
- **Role**: Read-Only User  
- **Permissions**:  
  - `SELECT` on Employees, Departments, Customers, Orders, Expenses, Salaries  

### 2. **HANAA** (Login: `HANAA_SERVER`)
- **Role**: Data Entry User  
- **Permissions**:  
  - `INSERT` on Employees, Departments, Customers, Orders, Expenses  
  - `SELECT` on Salaries  

### 3. **ASMAA** (Login: `ASMAA_SERVER`)
- **Role**: Procedure Executor  
- **Permissions**:  
  - `EXECUTE` on stored procedures for updating Employees, Departments, Customers, Orders, Expenses, Salaries  

---

## ⚙️ How to Use
1. Run the SQL script `guest_test_init.sql` in SQL Server Management Studio (SSMS).  
2. Log in with one of the created users (`HALA_SERVER`, `HANAA_SERVER`, or `ASMAA_SERVER`).  
3. Test permissions:  
   - HALA → can only read data.  
   - HANAA → can insert records.  
   - ASMAA → can update records using procedures.  

---

## 🛠️ Example Stored Procedure Usage
```sql
-- Login as ASMAA_SERVER
EXEC HR.UpdateEmployeePosition @EmpID = 1, @NewPosition = 'Senior HR Manager';

EXEC FINANCE.UpdateSalary @EmpID = 2, @PayDate = '2023-09-01', @NewSalary = 11000;
