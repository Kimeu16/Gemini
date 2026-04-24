# Official Email Branding & Emoji Removal

The goal is to standardize all system-generated emails to look professional and official by removing emojis and ensuring the company logo is consistently displayed.

## User Review Required

> [!IMPORTANT]
> - All symbols like ✅, ❌, 📧, 🔔, etc. will be removed from email subjects and bodies.
> - I will verify that the company logo transition from the local `public` folder to the email attachment is functioning correctly.

## Proposed Changes

### [Server]

#### [MODIFY] [email.service.ts](file:///c:/Apps/Leave%20Tracker/server/src/services/email.service.ts)
- Replace colorful emojis (✅, ❌, 🔔) with **professional Unicode symbols** or **styled CSS pill indicators**.
- Examples: 
  - `✅` → `[APPROVED]` or `✓`
  - `🔔` → `[NOTIFICATION]`
  - `⏳` → `[PENDING]`
- Ensure these symbols are high-contrast and match the corporate navy/gold palette.
- Embed the company logo at the top of every template using the existing CID mechanism.
- Remove all conversational emojis from email bodies to maintain an official tone.

## Verification Plan

### Automated Tests
- Send a test "Welcome" email to a dummy address and verify the HTML content (no emojis, logo present).
- Trigger a leave request notification and inspect the logs for the generated HTML.

### Manual Verification
- Ask the user to trigger a "Send All Emails" action (if they have a test user) and verify the arrival of a clean, official-looking email.
