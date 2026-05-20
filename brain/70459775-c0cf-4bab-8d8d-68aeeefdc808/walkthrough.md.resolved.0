# Walkthrough - Deletion of Leave Request (ADC-LVE-202605-A2023)

We have successfully processed the deletion of Jared Ratemo Nyakundi's erroneous leave request and notified him via email.

## Actions Completed

1. **Queried Jared's Leave Requests**:
   - Located the user record for `Jared  Ratemo Nyakundi` (`jared.nyakundi@adcea.com`).
   - Identified the specific leave request:
     - **Request ID**: `8a6593ab-0d6b-432c-b2af-48abf713f392`
     - **Request Number**: `ADC-LVE-202605-A2023`
     - **Type**: `ANNUAL`
     - **Period**: `30 May 2026` (0.5 days)
     - **Status**: `PENDING_OM`

2. **Sent Email Notification**:
   - Dispatched a branded system notification email to `jared.nyakundi@adcea.com` using the local corporate SMTP service.
   - Informed the user that the request `ADC-LVE-202605-A2023` was deleted due to an error, and instructed him to submit a fresh application.

3. **Removed Leave Request from Database**:
   - Executed a script using the `PrismaMssql` driver adapter to delete the record `8a6593ab-0d6b-432c-b2af-48abf713f392` from the `leave_requests` table.
   - Cleared references from other related models where applicable.

4. **Logged Audit Action**:
   - Registered a `DELETE_LEAVE_REQUEST` action in the system logs for audit compliance.

5. **Verified Database Integrity**:
   - Verified that the request has been deleted and only Jared's previous two leave requests remain.
