# Leave Approval Flow Test Plan

## Test 1: Projects Employee Leave Request
- [ ] Login as `projects_emp@test.com` (Password: `Test123!`)
- [ ] Submit a 2-day Annual Leave request
- [ ] Verify status is "Awaiting HOD Approval"
- [ ] Logout

## Test 2: Projects HOD Approval
- [ ] Login as `projects_hod@test.com` (Password: `Test123!`)
- [ ] Approve the employee's request
- [ ] Verify status is "Awaiting GM Approval"

## Test 3: Projects HOD Leave Request
- [ ] Submit a 2-day Annual Leave request as HOD
- [ ] Verify status is "Awaiting GM Approval"
- [ ] Logout

## Findings
- 
