# Code Optimization and Lint Fixing Plan

Fixing the identified code quality issues, linter errors, and warnings across the frontend and backend.

## User Review Required

> [!IMPORTANT]
> Some changes involve adding strict typing to existing code. While this improves stability, it requires ensuring the API response shapes match the new definitions.

## Proposed Changes

### Frontend Improvements

#### [MODIFY] [Reports.tsx](file:///c:/Apps/Leave%20Tracker/src/pages/Reports.tsx)
- Define interfaces for all data structures (`ReportLeaveRequest`, `ReportEmployee`, `MonthlyTrend`, etc.).
- Remove all remaining `any` type usage.
- Update `useQuery` calls with proper generics.
- Fix Recharts `CustomTooltip` typing.
- Replace `parseInt` with `Number.parseInt`.
- Fix React list keys (don't use indices).
- Add nullish coalescing and optional chaining where needed.

#### [MODIFY] [Sidebar.tsx](file:///c:/Apps/Leave%20Tracker/src/components/layout/Sidebar.tsx)
- Replace `window` with `globalThis` where applicable (though `window` is standard for browser-only code).

### Backend Improvements

#### [MODIFY] [stats.controller.ts](file:///c:/Apps/Leave%20Tracker/server/src/controllers/stats.controller.ts)
- Replace `parseInt` with `Number.parseInt`.
- Simplify negated conditions and complex logic.
- Use nullish coalescing instead of ternary for defaults.

#### [MODIFY] [bulk-upload-leave.ts](file:///c:/Apps/Leave%20Tracker/server/src/scripts/bulk-upload-leave.ts)
- Replace `parseFloat` with `Number.parseFloat`.
- Replace `isNaN` with `Number.isNaN`.
- Use `node:fs` and `node:path` imports.

### Documentation Polish

#### [MODIFY] [TECHNICAL_DOCS.md](file:///c:/Apps/Leave%20Tracker/TECHNICAL_DOCS.md)
- Fix markdown formatting errors (blank lines around headings and lists, indentation).

## Verification Plan

### Automated Tests
- Run `npm run lint` in both frontend and backend to verify issues are resolved.
- Run `npm run build` to ensure no new build breaks.

### Manual Verification
- Verify the Reports page still renders charts correctly and filters year data as expected.
- Verify export functionality (CSV/PDF) still works.
