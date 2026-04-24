# Walkthrough: Bulk Upload Finalization

I have completed the final preparations for your employee bulk upload. The application logic and the import data are now perfectly aligned.

## Changes Made

### 1. Frontend Alignment
- Updated [Employees.tsx](file:///c:/Apps/Leave%20Tracker/src/pages/Employees.tsx) to change the NOC department role from `NOC Office` to `NOC Officer` (`NOC_OFFICER`). 
- This ensures that the `Role` column in your CSV correctly matches the system's internal values.

### 2. CSV Data Cleanup
- Cleaned [Employees.csv](file:///c:/Apps/Leave%20Tracker/LeaveTracker_Employees%20%20-%20Employees.csv) by removing the following excluded records:
  - **Ronald Chola**
  - **Eric Nyakundi**
- Verified that your manual corrections for emails (Geoffrey and Belinda) and spelling (`SITE_SUPERVISOR`) are intact.

---

## Ready to Upload!

You are now **good to go**. You can proceed with the bulk upload via the UI:

1.  Click **Bulk Import** on the Employees page.
2.  Choose the [Employees.csv](file:///c:/Apps/Leave%20Tracker/LeaveTracker_Employees%20%20-%20Employees.csv) file.
3.  The "Suppress Welcome Emails" checkbox will be checked by default—keep it checked if you want to verify everything once more before notifying the team.
4.  Click **Start Import**.

> [!TIP]
> After the upload, use the **"Send Welcome Emails"** button in the header if you're ready to invite everyone to the system!
