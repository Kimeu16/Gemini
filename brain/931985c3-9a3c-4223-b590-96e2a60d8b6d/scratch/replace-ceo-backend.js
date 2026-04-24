const fs = require('fs');
const path = require('path');

const replacements = [
  // Status values
  ["PENDING_CEO", "PENDING_ADMIN"],
  ["REJECTED_CEO", "REJECTED_ADMIN"],
  // Role string
  ["'CEO'", "'ADMINISTRATOR'"],
  // Function rename
  ["ceoApproveLeaveRequest", "adminApproveLeaveRequest"],
  // Log action
  ["CEO_FINAL_APPROVE_LEAVE", "ADMIN_FINAL_APPROVE_LEAVE"],
  ["finalApprover: 'CEO'", "finalApprover: 'ADMINISTRATOR'"],
  // Notification messages
  ["finally approved by the CEO", "finally approved"],
  ["pending final CEO approval", "pending final Admin approval"],
  ["pending manual CEO signature", "pending Admin confirmation (after CEO manual signature)"],
  // Comments
  ["CEO Final Approval", "Admin Final Approval"],
  ["// CEO routes", "// Admin routes"],
  // Variable renames in gmApprove function
  ["ceoUsers", "adminUsers"],
  ["ceoEmailTemplate", "adminEmailTemplate"],
  ["map(async (ceo)", "map(async (admin)"],
  ["userId: ceo.id", "userId: admin.id"],
  ["to: ceo.email", "to: admin.email"],
  // CEO status label in email
  ["Status: Pending CEO Final Authorization", "Status: Pending Admin Final Confirmation"],
  ["CEO authorization", "Admin confirmation"],  
  ["approvalLevel = 'CEO'", "approvalLevel = 'Administrator'"],
  // Rejection label
  ["rejectedByRole = 'CEO'", "rejectedByRole = 'Administrator'"],
];

const files = [
  'server/src/controllers/leave.controller.ts',
  'server/src/controllers/reservation.controller.ts',
  'server/src/controllers/stats.controller.ts',
];

for (const file of files) {
  const filePath = path.join('c:/Apps/Leave Tracker', file);
  if (!fs.existsSync(filePath)) {
    console.log(`SKIP: ${file} not found`);
    continue;
  }
  let content = fs.readFileSync(filePath, 'utf8');
  let changeCount = 0;
  for (const [from, to] of replacements) {
    const before = content;
    content = content.split(from).join(to);
    if (content !== before) changeCount++;
  }
  fs.writeFileSync(filePath, content, 'utf8');
  console.log(`✅ ${file}: ${changeCount} replacement patterns applied`);
}

console.log('\nDone!');
