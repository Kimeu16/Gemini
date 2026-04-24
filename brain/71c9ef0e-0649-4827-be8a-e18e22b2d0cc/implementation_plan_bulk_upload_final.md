# Implementation Plan: Bulk Upload Finalization

Prepare the application and data for a clean bulk upload by aligning role names and removing excluded records.

## Proposed Changes

### Frontend

#### [MODIFY] [Employees.tsx](file:///c:/Apps/Leave%20Tracker/src/pages/Employees.tsx)
- Update the NOC department roles in the "Add New Employee" dropdown:
  - Change `NOC_OFFICE` to `NOC_OFFICER`.

### Data Cleanup

#### [MODIFY] [LeaveTracker_Employees  - Employees.csv](file:///c:/Apps/Leave%20Tracker/LeaveTracker_Employees%20%20-%20Employees.csv)
- [DELETE] **Ronald Chola** (Line 56)
- [DELETE] **Eric Nyakundi** (Line 57)

## Verification Plan

### Automated Tests
- Verify `Employees.tsx` compiles and the dropdown shows "NOC Officer".
- Read the CSV file to ensure the two excluded employees are gone and headers/other rows are intact.

### Manual Verification
- The user will perform the "Bulk Import" via the UI using the cleaned file.
