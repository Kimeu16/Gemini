const fs = require('fs');
const path = require('path');

const root = 'c:/Apps/Leave Tracker';

// === TARGETED FIXES ===

// 1. AdminDashboard.tsx - interface and variable names
fix('src/components/dashboard/AdminDashboard.tsx', [
  ['interface CEORequest {', 'interface AdminRequest {'],
  ['CEORequest | null', 'AdminRequest | null'],
  ['CEORequest, type', 'AdminRequest, type'],
  ['CEORequest)', 'AdminRequest)'],
  ['CEO Dashboard', 'Admin Dashboard'],
  ['pendingCEORequests', 'pendingAdminRequests'],
  ['pendingCEOReservations', 'pendingAdminReservations'],
  ["// CEO should see both", "// Admin should see both"],
  ['OM, GM & CEO', 'OM, GM & Admin'],
  ['"Request finally approved by CEO"', '"Request finally approved"'],
]);

// 2. UserGuide.tsx - guide labels/content
fix('src/pages/UserGuide.tsx', [
  ['"CEO Guide"', '"Admin Guide"'],
  ['Executive Workflow (CEO)', 'Admin Workflow'],
  ['As the CEO, you provide the final authorization for leave requests.', 
   'As the Administrator, you record the CEO\'s manual signature decisions in the system.'],
  ['next stage in the hierarchy (GM or CEO).', 'next stage in the hierarchy (GM or Admin).'],
  ['approval forwards it to the CEO.', 'approval forwards it to the Admin.'],
]);

// 3. Employees.tsx
fix('src/pages/Employees.tsx', [
  ['// Fetch pending welcome email count (for OM/CEO)', '// Fetch pending welcome email count (for OM/Admin)'],
  ['<SelectItem value="ADMINISTRATOR">CEO</SelectItem>', '<SelectItem value="ADMINISTRATOR">Administrator</SelectItem>'],
]);

// 4. CalendarView.tsx
fix('src/pages/CalendarView.tsx', [
  ['return `CEO: ${leave.approverName || "Approved"}`;', 'return `Approved: ${leave.approverName || "Approved"}`;'],
  ['return "Awaiting CEO...";', 'return "Awaiting Admin...";'],
  ['return "CEO Review";', 'return "Admin Review";'],
]);

// 5. Requests.tsx - toast descriptions (keep line 2139 signature label as-is)
fix('src/pages/Requests.tsx', [
  ['"Request approved (GM) and pending CEO signature"', '"Request approved (GM) and pending Admin confirmation"'],
  ['"Request finally approved by CEO"', '"Request finally approved"'],
]);

// 6. ApprovalTimeline.tsx
fix('src/components/ApprovalTimeline.tsx', [
  ["'CEO Final Executive Approval'", "'Admin Final Confirmation'"],
]);

// 7. StatusBadge.tsx
fix('src/components/StatusBadge.tsx', [
  ["label: 'Rejected by CEO'", "label: 'Rejected by Admin'"],
]);

// 8. useRoleAccess.ts - comments
fix('src/hooks/useRoleAccess.ts', [
  ['Check if user is a CEO', 'Check if user is an Administrator'],
  ['Check if user has management permissions (OM, GM, or CEO)', 'Check if user has management permissions (OM, GM, or Admin)'],
]);

// 9. Backend stats.controller.ts - variable names
fix('server/src/controllers/stats.controller.ts', [
  ['pendingCEORequests', 'pendingAdminRequests'],
  ['pendingCEOReservations', 'pendingAdminReservations'],
]);

// 10. Backend leave.controller.ts - comments and labels
fix('server/src/controllers/leave.controller.ts', [
  ['// Deduct balance immediately if auto-approved (CEO)', '// Deduct balance immediately if auto-approved (Administrator)'],
  ['// Get all CEOs', '// Get all Administrators'],
  ['// Create in-app notification for CEO', '// Create in-app notification for Admin'],
  ['// Send email notification to CEO', '// Send email notification to Admin'],
]);

console.log('\nAll targeted fixes applied!');

function fix(file, replacements) {
  const filePath = path.join(root, file);
  if (!fs.existsSync(filePath)) {
    console.log(`SKIP: ${file}`);
    return;
  }
  let content = fs.readFileSync(filePath, 'utf8');
  let count = 0;
  for (const [from, to] of replacements) {
    const before = content;
    content = content.split(from).join(to);
    if (content !== before) count++;
  }
  fs.writeFileSync(filePath, content, 'utf8');
  console.log(`✅ ${file}: ${count} fixes`);
}
