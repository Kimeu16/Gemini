const fs = require('fs');
const path = require('path');

const replacements = [
  // Status values
  ["PENDING_CEO", "PENDING_ADMIN"],
  ["REJECTED_CEO", "REJECTED_ADMIN"],
  // Role checks - be careful with quotes
  ['role === "CEO"', 'role === "ADMINISTRATOR"'],
  ['role === \'CEO\'', 'role === \'ADMINISTRATOR\''],
  ['"CEO"', '"ADMINISTRATOR"'],  // Will catch remaining "CEO" in arrays etc
  ["'CEO'", "'ADMINISTRATOR'"],
  // Mutation/API renames  
  ["ceoApprove", "adminApprove"],
  ["ceo-approve", "admin-approve"],
  // Dashboard rename
  ["CEODashboard", "AdminDashboard"],
  // User guide
  ['"ceo"', '"admin"'],
  ["CEOGuide", "AdminGuide"],
  // Role access hook
  ["isCEO", "isAdmin"],
  // Labels (keep "Chief Executive Officer" for PDF but update system labels)
  ["Pending CEO", "Pending Admin"],
  ["Rejected (CEO)", "Rejected (Admin)"],
  // PendingReservations mapping
  ["CEO: 'PENDING_ADMIN'", "ADMINISTRATOR: 'PENDING_ADMIN'"],  // Fix double replacement
];

const frontendFiles = [
  'src/types/leave.ts',
  'src/hooks/useRoleAccess.ts',
  'src/pages/Dashboard.tsx',
  'src/pages/Requests.tsx',
  'src/pages/MyHistory.tsx',
  'src/pages/Settings.tsx',
  'src/pages/Employees.tsx',
  'src/pages/CalendarView.tsx',
  'src/pages/UserGuide.tsx',
  'src/components/StatusBadge.tsx',
  'src/components/FullCalendarView.tsx',
  'src/components/ApprovalTimeline.tsx',
  'src/components/dashboard/CEODashboard.tsx',
  'src/components/dashboard/PendingReservations.tsx',
  'src/components/dashboard/EmployeeDashboard.tsx',
  'src/components/layout/Sidebar.tsx',
  'src/lib/corporatePdf.ts',
  'src/App.tsx',
];

const root = 'c:/Apps/Leave Tracker';

for (const file of frontendFiles) {
  const filePath = path.join(root, file);
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

// Now rename CEODashboard.tsx -> AdminDashboard.tsx
const oldPath = path.join(root, 'src/components/dashboard/CEODashboard.tsx');
const newPath = path.join(root, 'src/components/dashboard/AdminDashboard.tsx');
if (fs.existsSync(oldPath)) {
  // Read the already-modified content
  const content = fs.readFileSync(oldPath, 'utf8');
  fs.writeFileSync(newPath, content, 'utf8');
  fs.unlinkSync(oldPath);
  console.log('✅ Renamed CEODashboard.tsx -> AdminDashboard.tsx');
}

console.log('\nDone! Frontend replacements complete.');
