# Walkthrough - Projects Department Custom Approval Flow

I have implemented the specialized leave approval flow for the **Projects** department, where requests follow a custom hierarchy: **HOD Projects → General Manager (GM) → CEO**. 

## Key Features Implemented:

### 1. Custom Approval Routing
- **Employee → HOD**: Requests from Projects employees are automatically assigned `PENDING_HOD_PROJECTS` status.
- **HOD → GM**: HOD approval advances the request to `PENDING_GM`.
- **HOD Self-Approval**: Requests made by the HOD Projects themselves skip the HOD stage and move directly to `PENDING_GM`.

### 2. Automated Notifications (Email & In-App)
- **Correct Greetings**: New request emails now dynamically address the **Projects HOD** by their role instead of the generic "Operations Manager".
- **HOD Approval Alerts**:
    - **Employees** receive an email and in-app notification when their HOD approves.
    - **General Managers** receive an email and in-app notification alerting them that a Projects request is pending their endorsement.

### 3. Managerial Dashboard & Filtering
- **HOD Dashboard**: Users with the `HOD_PROJECTS` role see a tailored dashboard with relevant statistics and "Pending HOD Actions".
- **Request Filtering**: The "Department Leaves" and "All Requests" views now correctly filter for `PENDING_HOD_PROJECTS`.
- **Action Buttons**: The "Approve (HOD)" button appears exclusively for the HOD Projects on relevant requests.

### 4. Dynamic UI Progress Tracking
- **Status Badges**: Added "Awaiting HOD Approval" labels.
- **Approval Timeline**: For Projects department requests, the first step is dynamically labeled "Projects HOD Approval" instead of "Operations Manager Verification".

### 5. Server Restoration & Notification Finalization
- **Email Service Fix**: Resolved critical syntax errors in `email.service.ts` that were blocking the server. Corrected template literals and restored stable object structures.
- **Trigger Verification**: Confirmed that `createLeaveRequest` and `hodApproveLeaveRequest` correctly trigger both in-app and email notifications for all stakeholders (Employees, HOD Projects, and General Managers).
- **Health Check**: Verified server status via API health endpoints and confirmed production readiness.

## Verification Performed:
- **Backend Logic**: Verified through a programmatic test script simulating the full transition cycle.
- **Frontend UI**: Verified role-based button visibility and dashboard routing logic.
- **Notification Integrity**: Verified correct template selection and recipient logic in the controller.

---
> [!TIP]
> Use the test accounts `projects_emp@test.com` and `projects_hod@test.com` (Password: `Test123!`) to see the end-to-end flow in action!
