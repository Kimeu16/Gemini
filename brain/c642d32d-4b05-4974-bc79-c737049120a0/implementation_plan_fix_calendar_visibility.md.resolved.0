# Fix: Reserved Days Visibility in Calendar

The "Reserve Leave Days" feature is functional in the backend, but reservations are currently invisible on the calendar view due to missing status handling in the UI components.

## Proposed Changes

### 1. Sidebar Legend Fix

#### [MODIFY] [CalendarView.tsx](file:///c:/Apps/Leave%20Tracker/src/pages/CalendarView.tsx)
- Update the legend count calculation to use `filteredLeaves` (which includes reservations) instead of `allLeaves` (which only includes formal requests).
- **Target**: Line 470 where `count` is calculated.

### 2. Calendar Entry Styling Fix

#### [MODIFY] [FullCalendarView.tsx](file:///c:/Apps/Leave%20Tracker/src/components/FullCalendarView.tsx)
- Add `RESERVED` to the `statusLabelMap`.
- Update `eventContent` logic to:
    - Apply the `.bg-reserved` class (defined in `index.css`) when the status is `RESERVED`.
    - Use a dashed border and italicized text for a tentative "phantom" look.
    - Show the `CalendarClock` icon for reservations instead of the standard check/clock.

## Verification Plan

### Automated Tests
- None required for this UI fix.

### Manual Verification
1. Create a reservation on the **Requests** page.
2. Navigate to the **Calendar**.
3. Verify that the **"Reserved (Tentative)"** count in the sidebar is correct (increments to 1).
4. Verify that the reservation appears on the calendar grid with a **dashed border** and **striped background**.
