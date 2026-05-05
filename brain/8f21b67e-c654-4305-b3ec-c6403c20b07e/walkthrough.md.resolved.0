# System Configuration Update: CTO Roles & Profile

I have completed the updates to the system hierarchy and user management as requested.

## Changes Implemented

### 1. Approval Hierarchy & Reporting
- **CTO Reporting**: The **CTO**'s leave requests now route directly to the **General Manager** (`PENDING_GM`) for approval, rather than the Administrator.
- **Line Manager Routing**: If a user selects the **General Manager** as their handover line manager, the request is now correctly routed to the GM level.

### 2. CTO System Visibility
- **Employee Directory**: The CTO now has full access to the **Employee Directory**, including detailed profiles.
- **Management Access**: Added access for the CTO to the **Reports** and **Logs** sections in the sidebar.
- **API Authorization**: Updated backend routes to allow the CTO to perform administrative tasks like managing welcome emails and employee profiles.

### 3. Test Account Exclusion
- **User**: `ignitionx8@gmail.com` (Willis Ochieng)
- **Status**: Marked as `isTest: true` and `isActive: false`. This account will no longer appear in employee lists, reports, or system usage metrics.

### 4. Profile Update: Phineas Mwenda Kinoti
Updated the profile for `kinoti.mwenda@alandick.co.ke` with the following details:
- **Role**: CTO
- **Position**: CTO
- **Department**: EXECUTIVE
- **Gender**: MALE
- **Work Schedule**: MON_FRI
- **Leave Balances**: 
  - Annual: **63.5 days**
  - Sick: **10 days**
- **Phone**: 254721467896

## Verification
- Verified database updates for both user accounts.
- Confirmed logic in `leave.controller.ts` reflects the new reporting hierarchy.
- Confirmed `Sidebar.tsx` and `employee.routes.ts` permissions include the `CTO` role.
