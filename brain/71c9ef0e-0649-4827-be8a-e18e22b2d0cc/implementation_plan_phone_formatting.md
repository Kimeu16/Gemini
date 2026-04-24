# Implementation Plan: International Phone Number Formatting

Standardize the application to use the Kenyan international prefix (`254`) for all phone numbers. This is mandatory for all users as the organization operates exclusively in Kenya.

## User Review Required

> [!IMPORTANT]
> **Password Impact**: The application uses the employee's phone number as their initial temporary password. Changing the format in the database will change the initial password for any user who hasn't logged in yet.
> - **Recommendation**: We will only migrate phone numbers for users who have `requiresPasswordChange: true`.

## Proposed Changes

### 1. Shared Utilities & Normalization

#### [NEW] [phone.ts](file:///c:/Apps/Leave%20Tracker/src/utils/phone.ts) (and server equivalent)
Create a robust formatting function:
- Input: `0721...` -> Output: `254721...`
- Input: `+254721...` -> Output: `254721...`
- Input: `721...` -> Output: `254721...`

---

### 2. Frontend Updates

#### [MODIFY] [Employees.tsx](file:///c:/Apps/Leave%20Tracker/src/pages/Employees.tsx)
- Update the **CSV Import** logic to auto-format phone numbers during parsing.
- Add an `onBlur` formatter to the "Add Employee" and "Edit Employee" modals to ensure the `254` prefix is applied.
- Update the phone number placeholder to `2547...`.

#### [MODIFY] [Requests.tsx](file:///c:/Apps/Leave%20Tracker/src/pages/Requests.tsx)
- Format the "Contact while on leave" input to encourage the international format.

---

### 3. Backend Updates

#### [MODIFY] [employee.controller.ts](file:///c:/Apps/Leave%20Tracker/server/src/controllers/employee.controller.ts)
- Import/Implement the normalization utility.
- Format the `phone` field **before** it is used to hash the initial password and **before** saving to the database.
- This applies to `createEmployeeWithUser` and `bulkCreateEmployees`.

---

### 4. Database Migration

#### [NEW] [migrate-phone-numbers.ts](file:///c:/Apps/Leave%20Tracker/server/scripts/migrate-phone-numbers.ts)
Create a one-time script to:
1. Fetch all users with phone numbers.
2. Identify those in the old format (starting with `0`).
3. Update them to the `254` format.
4. **Safety**: Log each change to ensure auditability.

---

### 5. Login Page Support

#### [MODIFY] [Login.tsx](file:///c:/Apps/Leave%20Tracker/src/pages/Login.tsx)
- If the phone number is ever used in the login input (e.g., if you allow login via phone), implement auto-prefixing: if a user types `07...`, automatically convert it to `2547...` for the credential check.

## Open Questions
~~1. **Other International Numbers?**~~ -> **Confirmed**: Kenyan users only. Logic will be optimized for `254`.

## Verification Plan

### Automated Tests
- Run unit tests for the phone formatting utility with various inputs (`07...`, `+254...`, `7...`, `254...`).
- Verify hashing logic for initial passwords with the `254` prefix.

### Manual Verification
- **Local Dev**: Add a new employee with `0721364805` and verify the database stores `254721364805`.
- **Local Dev**: Upload a sample CSV with mixed formats and verify they all normalize to `254...`.
- **Database**: Run the migration script in a dry-run mode first to verify counts.
