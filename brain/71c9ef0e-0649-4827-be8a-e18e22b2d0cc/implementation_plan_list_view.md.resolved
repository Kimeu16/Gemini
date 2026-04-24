# Implementation Plan: Employee List View

Add a professional list-based view alternative to the existing card grid in the Team Directory, allowing administrators to manage all 50+ employees more efficiently.

## Proposed Changes

### Frontend

#### [MODIFY] [Employees.tsx](file:///c:/Apps/Leave%20Tracker/src/pages/Employees.tsx)
- **State Management**: Add a `viewMode` state (`'grid' | 'list'`) defaulting to `'grid'`.
- **UI Toggle**:
  - Add a view switcher (Grid/List icons) in the Team Directory section.
  - Position it near the header area or the directory tab content.
- **List View Implementation**:
  - Create a table-based layout using the `Table` component.
  - Columns: `Name`, `Position`, `Department`, `Work Schedule`, `Phone`, `Annual Balance`, `Actions`.
  - Maintain the department-based grouping (headers for each department) even in List View for better organization.
- **Animations**: Use `AnimatePresence` or simple motion transitions when switching between view modes.

## Verification Plan

### Automated Tests
- Verify `Employees.tsx` compiles without errors.
- Use the browser tool to toggle between Grid and List views and verify both render correctly with the 50+ employees.

### Manual Verification
1. Navigate to the Employees page.
2. Locate the new view switcher.
3. Switch to "List View".
4. Verify that the table columns are properly aligned and data for Kiprotich Davis (47 days) is correctly displayed.
5. Verify that the "Delete" and "View Profile" actions work in both modes.
