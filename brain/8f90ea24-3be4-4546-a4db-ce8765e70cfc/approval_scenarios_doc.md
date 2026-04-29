# 🏛️ Leave Approval: Delegation & Continuity Scenarios

This document outlines the official logical framework for leave request processing during management absence. The system is designed to ensure that no request is delayed due to the unavailability of a primary approver.

---

## 🎭 The Delegation Matrix
The following scenarios define how the system automatically re-routes authority when an primary approver is marked as **ABSENT** by the Administrator.

````carousel
### 🌑 Scenario 1: The CEO Absence (Final Stage)
**Context**: A request has been endorsed by the General Manager and is ready for final authorization.
**Condition**: The Administrator (CEO) is marked as **ABSENT**.
**Logic**: 
- The system detects the CEO's absence.
- The General Manager's endorsement is automatically promoted to **FINAL APPROVAL**.
- **Outcome**: The request is marked as `APPROVED`. No manual signature or Phase 3 action is required.

<!-- slide -->

### 🌓 Scenario 2: The GM/OM Dual-Role
**Context**: An Operations employee submits a leave request.
**Condition**: The Operations Manager (OM) is **ABSENT** and the General Manager (GM) is assigned as **SUBSTITUTE**.
**Logic**:
- The GM receives the initial notification.
- Upon GM approval, the system recognizes the GM holds both "Substitute OM" and "Primary GM" authority.
- **Outcome**: The request "Double-Jumps" directly to the Administrator (CEO), skipping the separate GM endorsement step.

<!-- slide -->

### 🌕 Scenario 3: Technical Leadership Proxy
**Context**: A request requires GM endorsement.
**Condition**: The General Manager (GM) is **ABSENT** and the CTO is assigned as **SUBSTITUTE**.
**Logic**:
- The CTO is granted authority to sign at the GM level.
- The original GM receives a shadow notification: *"A request was processed on your behalf by the CTO."*
- **Outcome**: The request proceeds to the Administrator with the CTO's signature acting as the valid endorsement.

<!-- slide -->

### 🌌 Scenario 4: Departmental Continuity
**Context**: A Projects employee submits a leave request.
**Condition**: HOD Projects is **ABSENT**.
**Logic**:
- The Admin assigns the CTO or GM as the substitute.
- Request routing shifts immediately to the assigned substitute.
- **Outcome**: Continuity is maintained within the Projects department without manual intervention by the employee.
````

---

## 📬 Communication Protocol (Rule #6)

When a substitute performs an action, the following automated communications are triggered:

1.  **To the Substitute**: Notification includes the prefix `[ACTING ON BEHALF]`.
2.  **To the Expected Approver**: A courtesy notice is sent summarizing the action taken:
    > *"Notification: A leave request for [Employee Name] has been [Approved/Rejected] on your behalf by [Substitute Name]. Status: Logged for Audit."*
3.  **Exception**: The CEO (Administrator) does not receive automated notifications to minimize inbox clutter, as per the established system-wide policy.

---

## 🛠️ Admin Control Dashboard

Admins have access to the **Delegation Control Center**, allowing real-time management of:
- **Presence Toggles**: Instantly mark any leader as Away/Present.
- **Authority Mapping**: Dynamically assign substitutes based on current organizational needs.
- **Audit Logs**: Every delegated approval is tagged with both the *Acting* and *Expected* approvers for compliance.

> [!NOTE]
> These rules ensure that the Leave Tracker remains a "Zero-Lag" system, prioritizing employee experience and operational efficiency.
