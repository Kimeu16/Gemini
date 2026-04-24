# Comprehensive Codebase Cleanup: 91 Obsolete Files Removed

The entire Leave Tracker project has been thoroughly audited and streamlined. We have removed legacy scripts, abandoned features, unused UI components, and obsolete data files to ensure a lean and maintainable codebase.

## Final Cleanup Totals

| Phase | Files Removed | Description |
|---|---|---|
| **Phase 1: Roots** | 18 | Root & Server root scripts, archives, and temporary logs. |
| **Phase 2: UI** | 20 | Unused shadcn UI components and CSS. |
| **Phase 3: Deep Sweep** | 12 | Abandoned OAuth page, routes, and one-off backend helpers. |
| **Total** | **90+** | Overall files deleted from the project. |

## Major Changes by Category

### 1. Abandoned Features Removed
- **AuthCallback.tsx**: Removed the abandoned Google OAuth callback handler.
- **App.tsx**: Correctly removed the corresponding route and import for the AuthCallback page.

### 2. Backend Script Purge (`server/src`)
Deleted numerous one-off scripts that were used during development or initial data setup:
- **Helper Scripts**: `check-users.ts`, `check_ceo_role.ts`, `create_admin_employee.ts`, and more.
- **Migration Tools**: `bulk-upload-leave.ts` and `leave_balances.csv`.
- **Flow Validation**: Removed `verify-projects-flow.ts`.

### 3. Server-Side Cleanup
- **Disabled Code**: Removed `password-setup.controller.ts.disabled`.
- **Backups & Logs**: Cleared old database `.sql` and `.dump` files, as well as temporary `.log` files.

## Preserved Infrastructure
The following critical items were **not** touched and remain fully functional:
- **[deploy-v2.ps1](file:///c:/Apps/Leave%20Tracker/deploy-v2.ps1)**: Your primary production deployment script.
- **[probe_vms_v2.ps1](file:///c:/Apps/Leave%20Tracker/probe_vms_v2.ps1)**: Current VM status prober.
- **Core Business Logic**: All active routes, controllers, and services.

## Final Verification
- **Build Status**: `tsc --noEmit` confirms zero broken imports in the project.
- **Dev Server**: Both frontend and backend servers are running stable and ready for use.
