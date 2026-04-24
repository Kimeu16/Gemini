# System-Wide Responsiveness Completion Plan

Ensure every feature in the Leave Tracker system is fully responsive, providing a premium experience on mobile phones, tablets, laptops, and large desktops.

## Proposed Changes

### 1. Dashboard Responsiveness (Completed/Refined)
- Already updated `OMDashboard.tsx`, `GMDashboard.tsx`, and `CEODashboard.tsx` to use a flexible grid: `grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-6`.
- **Verify**: Check that long labels like "Staff Planning Forecast" don't break the card layout on narrow mobile screens (320px-375px).

---

### 2. Request Management (`Requests.tsx`)
Currently, the request list uses a standard HTML table. While it has horizontal overflow, it's not ideal for mobile.
- **[MODIFY]** [Requests.tsx](file:///c:/Apps/Leave%20Tracker/src/pages/Requests.tsx)
  - Implement a **Responsive Data Container**:
    - Hide the `<table>` on mobile (`hidden md:table`).
    - Create a **Mobile Card View** (`grid grid-cols-1 gap-4 md:hidden`) that displays each request as a rich card with all relevant info (Avatar, StatusBadge, Actions).
  - **Filter Optimization**: Ensure the search and filter bar (currently `grid-cols-1 md:grid-cols-5`) doesn't consume the entire viewport height on mobile.

---

### 3. Employee Management (`Employees.tsx`)
- Already updated the `Annual Processing` tab hero buttons to stack.
- **[MODIFY]** [Employees.tsx](file:///c:/Apps/Leave%20Tracker/src/pages/Employees.tsx)
  - **Mobile Table View**: Implement a card view for the `Annual Processing` preview table when viewed on mobile.
  - **Directory Tabs**: Ensure the "Team Directory" and "Annual Processing" buttons are easy to tap on narrow screens.

---

### 4. Analytics & Reports (`Reports.tsx`)
- **[MODIFY]** [Reports.tsx](file:///c:/Apps/Leave%20Tracker/src/pages/Reports.tsx)
  - **Chart Sizing**: Verify `ResponsiveContainer` heights are optimal for mobile (sometimes charts feel too tall on small screens).
  - **KPI Grid**: Ensure the summary cards (`Total Requests`, `Approved`, etc.) look good on mobile.
  - **Department Table**: Wrap the bottom department table in a standard responsive container or convert to cards on mobile.

---

### 5. Audit Logs (`Logs.tsx`)
- **[MODIFY]** [Logs.tsx](file:///c:/Apps/Leave%20Tracker/src/pages/Logs.tsx)
  - **Mobile Layout**: Audit logs are data-dense. I will implement a "Compact Card" view for mobile that highlights the `Action`, `User`, and `Time`.

---

### 6. Common Components
- **[MODIFY]** `StatusBadge.tsx`: Ensure it doesn't wrap unnecessarily.
- **[MODIFY]** `StatCard.tsx`: Ensure labels wrap or truncate gracefully.

## Verification Plan

### Automated Verification
- I will use the `browser_subagent` to test the application at multiple viewports:
  - **Mobile**: 375px (iPhone)
  - **Tablet**: 768px (iPad)
  - **Desktop**: 1440px+
- I will verify that no elements overflow horizontally and that all buttons remain reachable and interactive.

### Manual Verification
- The user should verify the "feel" of the mobile navigation and card views.
- Test the "Reservation Approvals" StatCard deep-linking logic on mobile.
