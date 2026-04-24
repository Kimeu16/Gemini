# Relocating Carry-Forward Feature for OM

The goal is to move the "Year-End Leave Carry Forward" logic from the settings page to a more visible and accessible location exclusively for the Operations Manager (OM).

## User Review Required

> [!IMPORTANT]
> I am proposing to move this administrative task directly onto your **Dashboard** as a prominent utility card. This ensures you don't have to menu-dive into settings once a year.
> 
> **Proposed placement options:**
> 1.  **OM Dashboard Widget**: A dedicated card on your main landing page.
> 2.  **Employees Page Tab**: A new "Annual Processing" tab alongside the employee list.
> 3.  **Dedicated Admin Page**: A new 'Admin Tools' sidebar item.

## Proposed Changes

### [Component Name] OMDashboard

#### [MODIFY] [OMDashboard.tsx](file:///c:/Apps/Leave%20Tracker/src/components/dashboard/OMDashboard.tsx)
- Integrate the `handlePreview` and `handleProcess` logic currently in `CompanySettings.tsx`.
- Add a visually distinct `Card` for "Year-End Carry Forward".
- Display the preview results within a modal or an expandable section on the dashboard.

### [Component Name] Settings

#### [MODIFY] [CompanySettings.tsx](file:///c:/Apps/Leave%20Tracker/src/components/settings/CompanySettings.tsx)
- Remove the "Year-End Leave Carry Forward" section.
- Clean up related imports (`RefreshCw`, `ArrowRightLeft`, etc. if no longer used).

### [Component Name] Layout

#### [MODIFY] [Sidebar.tsx](file:///c:/Apps/Leave%20Tracker/src/components/layout/Sidebar.tsx)
- (Optional) If we choose the "Dedicated Page" route, add a new `NavItem`.

## Verification Plan

### Automated Tests
- Verify that the Carry-Forward widget is **only** visible to users with the `OPERATIONS_MANAGER` role.
- Verify that clicking "Preview" correctly fetches data from `/carryforward/preview`.
- Verify that clicking "Process" successfully updates balances via `/carryforward/process`.

### Manual Verification
- Log in as an Employee: Ensure the widget is NOT visible.
- Log in as OM: Ensure the widget is prominent and functional.
- Validate that the Settings page is now cleaner and focused on general preferences.
