# Resolve UI Performance Issues via Background Notifications

The user experiences significant delays (3-5+ seconds) when submitting, approving, or rejecting leave requests. This is caused by the backend waiting for external SMTP (email) and API (WhatsApp) operations to complete before responding to the client.

## Proposed Changes

We will refactor the leave request controllers to perform notification tasks (Email and In-app notifications) as background operations. This allows the server to respond to the user immediately after the database update is confirmed.

### [Component Name] Backend Controllers

#### [MODIFY] [leave.controller.ts](file:///C:/Apps/Leave%20Tracker/server/src/controllers/leave.controller.ts)
- Remove `await` from all `sendEmail` calls.
- Remove `await` from all `prisma.notification.create` calls that are part of the notification flow (where appropriate).
- Wrap these background calls in a `Promise.all(...).catch(...)` block to ensure they execute but don't block the main thread, while still logging any failures.

#### [MODIFY] [email.service.ts](file:///C:/Apps/Leave%20Tracker/server/src/services/email.service.ts)
- Ensure the `sendEmail` function handles its own errors gracefully so background execution doesn't crash the process (it already has a try-catch).

## Verification Plan

### Automated Tests
- Use a test script to trigger a leave action and measure the response time.
- Verify that emails are still delivered even when the HTTP response has already been sent.

### Manual Verification
- Perform a leave submission/approval in the UI and observe the immediate transition/success message.
- Check server logs to confirm "Email sent successfully" appears *after* the request has completed.
