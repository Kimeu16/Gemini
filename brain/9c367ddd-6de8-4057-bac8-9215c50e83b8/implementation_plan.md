# Documentation Update: Administrator Role Transition

This plan covers the systematic update of all project documentation to reflect the recent transition from the 'CEO' role to the 'ADMINISTRATOR' role.

## User Review Required

> [!IMPORTANT]
> The 'CEO / Managing Director' label on the final PDF signature line will remain unchanged to accommodate manual processes, but all system-level documentation will refer to the 'ADMINISTRATOR' role for the final Phase 3 approval stage.

## Proposed Changes

### Documentation Components

---

#### [MODIFY] [Technical_Guide.html](file:///c:/Apps/Leave%20Tracker/Technical_Guide.html)
- Replace all instances of the 'CEO' role with 'Administrator'.
- Update the approval flow description (Phase 3).
- Update the role hierarchy table and endpoint authorization descriptions.
- Update CSS classes from `.role-ceo` to `.role-admin` if applicable (checking for usage).

#### [MODIFY] [TECHNICAL_DOCS.md](file:///c:/Apps/Leave%20Tracker/TECHNICAL_DOCS.md)
- Standardize role definitions (replace 'CEO' with 'Administrator').
- Update leave status descriptions (e.g., `PENDING_CEO` -> `PENDING_ADMIN`).

#### [MODIFY] [Flow.md](file:///c:/Apps/Leave%20Tracker/wiki/1-Architecture/Flow.md)
- Update Mermaid diagrams to replace the 'CEO' participant with 'Administrator'.
- Rename flow steps from 'CEO Approval' to 'Administrator Confirmation'.

---

### Scripts & Utilities

#### [MODIFY] [create-ceo.ts](file:///c:/Apps/Leave%20Tracker/server/create-ceo.ts) -> [create-admin.ts](file:///c:/Apps/Leave%20Tracker/server/create-admin.ts)
#### [MODIFY] [get-ceo.ts](file:///c:/Apps/Leave%20Tracker/server/get-ceo.ts) -> [get-admin.ts](file:///c:/Apps/Leave%20Tracker/server/get-admin.ts)
- Update code to use 'ADMINISTRATOR' role constant.

## Open Questions

- Should we also rename the CSS class `.role-ceo` in the technical guide, or just the text? I plan to update the text labels first.

## Verification Plan

### Manual Verification
- View the rendered `Technical_Guide.html` in the browser.
- Verify the `Flow.md` diagram renders correctly with the new 'Administrator' participant.
- Grep for any remaining 'CEO' references in a final sweep.
