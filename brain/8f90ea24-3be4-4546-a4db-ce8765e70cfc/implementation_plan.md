# Implementation Plan: Corporate Delegation Dashboard

Finalize the delegation workflow by providing a high-fidelity administrative interface for managing approver absences and automated substitution routing.

## User Review Required

> [!IMPORTANT]
> The Delegation Dashboard will be accessible only to the **Administrator** role. It will control the "Away" status of key personnel (OM, GM, CTO, HOD Projects), which directly impacts the automated approval routing logic implemented in the controllers.

## Proposed Changes

### [Backend] Refactoring & Cleanup

#### [MODIFY] [delegation.controller.ts](file:///c:/Apps/Leave%20Tracker/server/src/controllers/delegation.controller.ts)
- Fix role constant names (use `ADMIN` instead of `ADMINISTRATOR`).
- Ensure type safety for `isAway` and `substituteId` fields.

#### [MODIFY] [delegation.routes.ts](file:///c:/Apps/Leave%20Tracker/server/src/routes/delegation.routes.ts)
- Fix middleware imports (`authenticate` and `authorize`).
- Use correct role key `ADMIN`.

### [Frontend] Delegation Dashboard

#### [NEW] [Delegation.tsx](file:///c:/Apps/Leave%20Tracker/src/pages/Delegation.tsx)
- Create a premium, dark-mode-ready dashboard for managing delegations.
- **Features**:
  - Grid of Approver Cards with glassmorphism effects.
  - Real-time "Away" toggle switches with Framer Motion animations.
  - Substitute selection dropdowns with live filtering.
  - Audit status indicators (last updated, current proxy).
  - "World Class" aesthetics using Tailwind CSS and Lucide icons.

#### [MODIFY] [App.tsx](file:///c:/Apps/Leave%20Tracker/src/App.tsx)
- Register the `/delegation` route.
- Restrict access to the `ADMINISTRATOR` role.

#### [MODIFY] [Sidebar.tsx](file:///c:/Apps/Leave%20Tracker/src/components/layout/Sidebar.tsx) (checking location)
- Add "Delegation" to the navigation menu for Administrators.

## Verification Plan

### Automated Tests
- `npx prisma generate` to confirm schema alignment.
- Verify API endpoints `/api/delegation/status` and `/api/delegation/update` via diagnostic scripts.

### Manual Verification
1. Log in as Administrator.
2. Navigate to the new Delegation page.
3. Toggle an approver (e.g., General Manager) as "Away".
4. Assign a substitute.
5. Verify that the "Away" status persists and reflects in the database.
6. (Optional) Submit a leave request and verify it follows the delegation "Double-Jump" or "CEO Bypass" logic.
