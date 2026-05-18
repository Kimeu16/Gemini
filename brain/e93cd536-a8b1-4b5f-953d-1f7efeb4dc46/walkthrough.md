# Walkthrough - Employee Ronald Chola Added

We have successfully added the new employee, **Ronald Chola**, to the Leave Tracker system. All details have been provisioned in the remote database (SQL Server) and synchronized inside the root-level employee CSV file.

## Changes Made

### 1. Database Provisioning (SQL Server)
We executed a custom TypeScript migration script that:
*   Checked if `cholaronny@gmail.com` already exists in the `User` and `Employee` tables.
*   Successfully created a new **User** record with:
    *   **Name**: `Ronald Chola`
    *   **Email**: `cholaronny@gmail.com`
    *   **Role**: `FIELD_ENGINEER`
    *   **Phone**: `254724945895` (normalized)
    *   **Password**: A secure `bcrypt` hash of the normalized phone number, allowing Ronald to perform his first login using his phone number.
    *   **Status flags**: `isActive: true`, `isTest: false` (to prevent being hidden by test filters), `emailVerified: false`, `requiresPasswordChange: true`.
*   Successfully created the corresponding **Employee** profile with:
    *   **Position**: `FIELD_ENGINEER`
    *   **Department**: `MAINTENANCE`
    *   **Gender**: `MALE`
    *   **Work Schedule**: `MON_SAT`
    *   **Leave Balances**: `{"annual": 26, "sick": 10, "casual": 5, "unpaid": 0}` (per requested custom balances of 26 annual leave days and 10 sick leave days).

### 2. Master CSV Update
We modified the master record file:
*   **Modified**: [LeaveTracker_Employees  - Employees (1).csv](file:///c:/Apps/Leave%20Tracker/LeaveTracker_Employees%20%20-%20Employees%20(1).csv#L56)
*   We filled in the missing annual leave balance of `26` for Ronald Chola to ensure it matches the database perfectly.

---

## Verification Results

We verified the addition by running a query script against the active database:

```
[INFO] Found in User table:
  Name: Ronald Chola
  Email: cholaronny@gmail.com
  Role: FIELD_ENGINEER
  Phone: 254724945895
  IsActive: true
  IsTest: false
[INFO] Found Employee Profile:
  Position: FIELD_ENGINEER
  Department: MAINTENANCE
  Gender: MALE
  Work Schedule: MON_SAT
  Balances: {"annual":26,"sick":10,"casual":5,"unpaid":0}
```

The employee is now fully active, secure, and properly tracked in both the live database and CSV registry.
