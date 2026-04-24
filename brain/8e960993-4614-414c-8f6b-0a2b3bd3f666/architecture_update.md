# Leave Tracker System Architecture

I have generated a professional-grade architectural flow diagram for the system. This version fixes the previous typos and uses a more modern, premium aesthetic.

## New System Flow Diagram
![System Flow Diagram](file:///c:/Apps/Leave%20Tracker/wiki/1-Architecture/flow_diagram_v2.png)

## Architectural breakdown
The system is divided into four main layers:

| Layer | Component | Responsibility |
| :--- | :--- | :--- |
| **User Zone** | Windows/Laptop, Mobile | Client-side interface for employees and managers. |
| **Security Gateway** | Nginx Reverse Proxy & JWT | SSL termination, request routing, and token validation. |
| **Application Server** | Node.js (Express) | Business logic for leave calculations, role-based access, and SMTP notifications. |
| **Internal Database** | MS SQL Server | Persistent storage for users, leave types, and transaction logs. |

### Would you like me to:
1. **Replace** the existing `flow_diagram.png` in the wiki with this one?
2. **Update** the documentation to reflect any further architectural changes?
