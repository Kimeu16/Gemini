# Implementation Plan: Premium Yearly Calendar Overhaul

Transform the Yearly (Multi-Month) view from a cluttered list into a sleek, high-density overview optimized for corporate planning.

## Proposed Changes

### [Frontend] Calendar Component

#### [MODIFY] [FullCalendarView.tsx](file:///c:/Apps/Leave%20Tracker/src/components/FullCalendarView.tsx)
-   **Multi-Column Optimization**: Set `multiMonthMaxColumns: 3` to create a balanced grid on desktop.
-   **Adaptive Event Rendering**:
    -   Implement conditional logic in `eventContent`:
        -   `dayGridMonth`: Keep the detailed pills with avatars.
        -   `multiMonthYear`: Switch to **Compact Status Dots** arranged in a flex-wrap container.
-   **Heatmap Day Styling**:
    -   Use `dayCellContent` or `dayCellDidMount` to apply a subtle background highlight to days with active leaves.
-   **Premium CSS Polish**:
    -   Style `.fc-multimonth-month` with more padding and a glassmorphism border.
    -   Enhance `.fc-multimonth-title` (Month Names) with `Outfit` font, bold weight, and primary color accents.
    -   Increase cell height in yearly view to accommodate more dots without "+more" overlaps.

## Verification Plan

### Automated Tests
-   Verify view switching transition from Month -> Year.
-   Check responsiveness on smaller screens (ensure columns stack).

### Manual Verification
-   Ensure "Today" remains highly visible in the multi-month grid.
-   Verify hover tooltips work correctly on the tiny status dots.
