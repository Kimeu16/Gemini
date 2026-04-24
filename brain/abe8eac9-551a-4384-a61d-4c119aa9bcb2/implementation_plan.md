# Dynamic Calendar Integration Plan

## Goal
To visually enhance the Leave Application process by replacing native browser date inputs with a powerful, interactive Calendar UI. This calendar will dynamically highlight and disable non-working days (weekends and Kenyan Public Holidays) based on the employee's specific work schedule (`MON_FRI` vs `MON_SAT`), making the leave calculation perfectly transparent.

## Proposed Approach

Currently, the Leave Request system relies on the browser's native `<input type="date">`. While functional, the native picker cannot be customized to visually highlight or restrict specific non-working days. 

To achieve your vision, we will implement a custom interactive Calendar using `react-day-picker` (already present in your dependencies).

### 1. UI Infrastructure updates
*   **Create core `Calendar` component (`src/components/ui/calendar.tsx`)**: Establish the foundational UI component styled accurately to your company's existing Shadcn / Tailwind ecosystem.
*   **Create a `DatePicker` component (`src/components/ui/date-picker.tsx`)**: Build the Popover wrapper that allows the calendar to function exactly like a standard dropdown input.

### 2. Schedule-Aware Business Logic
We will inject contextual rules directly into the new Calendar using React-Day-Picker's "modifiers" feature:
*   **Kenyan Holidays**: We will use your existing `isKenyanPublicHoliday` utility to flag non-working holidays.
*   **`MON_FRI` Schedule**: We will flag all Saturdays and Sundays as non-working days.
*   **`MON_SAT` Schedule**: We will flag all Sundays as non-working days.

*Visual Behavior*:
*   Non-working days will be visibly greyed-out or styled with muted text / red tints indicating they do not consume leave balance.
*   Users will be blocked from explicitly picking a Sunday or Holiday as their *Start* or *End* Date.
*   When a user selects a long range (e.g., crossing over a weekend), the non-working days in the middle of the range will be visually skipped/muted to reflect the accurate computation of the leave days.

### 3. Form Upgrades (`src/pages/Requests.tsx`)
*   **Standard Leave Ranges**: Replace `StartDate` and `EndDate` text inputs with the new smart DatePickers.
*   **Scattered Leaves (Enhancement)**: We will replace the current visual grid of scattered leave buttons with a `Calendar mode="multiple"`. This means users can just click arbitrarily on the standard month calendar to pick their scattered dates—resulting in a significantly, exponentially better user experience.

## User Review Required

> [!IMPORTANT]
> **Scattered Leaves Upgrade**: Switching to `react-day-picker` in "multiple" select mode provides an incredible UI for "Scattered Dates". Do you approve of replacing the current grid of buttons inside the Scattered Leave form with this new interactive multi-select Calendar? 

Please review the plan above. If it aligns with your expectations, say **"Proceed"** and I will begin the implementation immediately.
