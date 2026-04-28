# CTO Approval Delegation & Dashboard Walkthrough

This comprehensive update ensures business continuity by delegating General Manager authority to the CTO during periods of absence.

## 1. Adaptive CTO Dashboard
A new specialized dashboard has been created for the CTO role (`CTODashboard.tsx`).

- **Standby Mode**: When the GM is active, the dashboard shows personal leave stats and a "Leadership Status" indicator (Emerald).
- **Delegation Mode**: When the GM is away, a high-visibility **"Active Delegation Mode"** alert (Amber) appears.
- **Dynamic Widgets**: A "Delegated GM Approvals" card instantly surfaces, allowing the CTO to endorse or reject pending requests without leaving the dashboard.

## 2. Out of Office (Away) Management
The General Manager can manually trigger delegation through the "Delegation & Availability" card on their Profile.

- **Manual Toggle**: Sets the `isAway` flag in the database.
- **Impact**: Instantly activates the CTO's delegated dashboard and approval buttons.

## 3. Hybrid Absence Detection Engine
The system automatically identifies GM absence by checking:
1. The manual `isAway` toggle status.
2. Any active, approved leave requests for the GM that cover the current date.

### Detection Utility (`approvalUtils.ts`):
Centralized logic ensures consistency between the frontend UI and backend security guards.

## 4. Secure Backend Delegation
- **Authorized Endorsements**: The `gmApproveLeaveRequest` controller now accepts CTO endorsements when the GM is verified as away.
- **Security Guard**: CTOs are blocked from endorsing if the GM is active, preventing unauthorized overrides.

## 5. Audit-Ready Communications
- **Role-Based Notifications**: Emails to employees now dynamically reflect the correct role (e.g., "Endorsed by CTO (on behalf of GM)").
- **Audit Trail**: The database captures the exact identity of the endorser for every request.

## Verification Plan

### Automated Checks
- Verified SQL Server schema migration for the `isAway` field.
- Confirmed type safety across `CTODashboard.tsx` and `leave.controller.ts`.

### Manual Verification Required
1. **GM Toggle Test**: Log in as GM, enable "Away" mode. Log in as CTO and verify the Amber alert and pending requests appear on the dashboard.
2. **Endorsement Flow**: As CTO, endorse a request from the dashboard. Verify the employee receives an email stating it was endorsed by the "CTO (on behalf of GM)".
3. **Standby Test**: Log in as GM, disable "Away" mode. Verify the CTO dashboard returns to "Standby" mode and endorsement buttons are hidden.
