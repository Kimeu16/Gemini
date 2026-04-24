# Walkthrough: Employee List View \u0026 Record Rectification

I have implemented the new **List View** feature and finalized the record corrections for your team directory.

## 1. New "List View" Feature
You can now toggle between two views in the **Team Directory**:

*   **Grid View (Default)**: Visual cards with avatars, ideal for seeing faces and positions.
*   **List View (New)**: A high-density table that shows more employees at once. 
    *   **Data Visibility**: Includes **Phone Numbers** and **Annual Leave Balances** directly in the row.
    *   **Department Grouping**: Maintains the department grouping headers for easy navigation even in list mode.
    *   **Tooltips**: Hover over the view switcher buttons to see the labels.

## 2. Record Rectification: Kiprotich Davis
*   **Correction**: Verified that Kiprotich Davis should have **47 days** of annual leave according to the master CSV.
*   **Database Update**: I updated his database record (it was previously 24 days).
*   **Status**: Successfully verified; his balance is now correctly reflected in both the Grid and List views.

---

## Technical Details
- Added `viewMode` state to `Employees.tsx`.
- Integrated Shadcn `Table` components for the List View layout.
- Added `LayoutGrid` and `List` icons from Lucide-React for the toggle UI.
- Increased `PAGINATION.DEFAULT_LIMIT` to `100` (from our previous task) to ensure 100% visibility in both modes.

### Verification
- [x] Toggle UI functions correctly.
- [x] List View renders all expected columns (Name, Position, Schedule, Phone, Balance).
- [x] Kiprotich Davis balance checked in DB and updated.
