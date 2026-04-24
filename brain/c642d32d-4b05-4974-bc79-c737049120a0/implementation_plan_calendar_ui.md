# Implementation Plan: Premium Leave Calendar Overhaul

This plan outlines a comprehensive UI/UX redesign of the Calendar view to elevate it to a "World-Class" standard, moving beyond the standard FullCalendar look into a cohesive, branded, and high-fidelity experience.

## Proposed Changes

### 1. Calendar View Component ([FullCalendarView.tsx](file:///c:/Apps/Leave%20Tracker/src/components/FullCalendarView.tsx))
- **Custom React Header**: Replace standard FullCalendar buttons with a custom toolbar featuring:
    - **Animated View Switcher**: A segmented control (Month/Week/Year/List) with sliding highlights.
    - **Modern Navigation**: Styled previous/next icons and a "Today" button.
- **Enhanced Aesthetic System**:
    - **Type-First Coloring**: Reintroduce vibrant colors for leave types (Annual: Sky, Sick: Rose, etc.) while using a status indicator (dot/icon) for approval progress.
    - **Pill-Shaped Events**: Rounded event tags with delicate shadows and better padding.
    - **Cell Highlighting**: Use glassmorphism highlights for "Today" and a subtle muted state for weekends.
    - **Minimalist Grid**: Replace heavy borders with a clean, row-highlighting layout.
- **Improved Tooltips & Modals**:
    - Polish the floating tooltips for better readability and a more "floating" effect.
    - Enhance the modal detail view with better typography and layout balance.

### 2. Page Wrapper ([CalendarView.tsx](file:///c:/Apps/Leave%20Tracker/src/pages/CalendarView.tsx))
- **Sidebar Polishing**:
    - Refine the "Approval Progress" legend with consistent iconography.
    - Improve the "Upcoming Leaves" scrollable area with better empty states and smooth dividers.

## UI Design Goals
- **Glassmorphism**: Consistent use of `backdrop-blur` and thin borders.
- **Premium Interaction**: Micro-animations on hover and view transitions.
- **AlanDick Branding**: Strong use of Corporate Navy and Gold accents.

## Verification Plan

### Manual Verification
- Test all view toggles (Year/Month/Week/Day/List).
- Verify tooltip positioning and responsiveness.
- Check dark mode compatibility.
- Ensure all leave types are correctly color-coded.
