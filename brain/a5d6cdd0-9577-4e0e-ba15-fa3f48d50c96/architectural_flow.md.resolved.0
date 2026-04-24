# Leave Tracker Architectural Flow

This document provides a comprehensive overview of the architecture and data flows for the Leave Tracker system.

## 1. High-Level System Architecture

The system follows a modern client-server architecture with a clear separation of concerns between the frontend, backend, and database layers.

```mermaid
graph TD
    subgraph "Client Layer"
        User((User/Employee))
        Manager((Manager/CEO))
        Frontend[React Frontend - Vite]
    end

    subgraph "API Layer (Server)"
        API[Express API Server]
        Auth[Auth Middleware - JWT/Passport]
        Controllers[Business Logic Controllers]
        Services[Email & Backup Services]
    end

    subgraph "Data Layer"
        ORM[Prisma ORM]
        DB[(MS SQL Server)]
    end

    subgraph "External Services"
        Google[Google OAuth 2.0]
        SMTP[Gmail SMTP Server]
    end

    User -->|Interacts| Frontend
    Manager -->|Approves| Frontend
    Frontend -->|REST API Requests| API
    API -->|Validates| Auth
    Auth -->|Redirect| Google
    API -->|Handles Logic| Controllers
    Controllers -->|Queries| ORM
    ORM -->|Persistence| DB
    Controllers -->|Triggers| Services
    Services -->|Sends Emails| SMTP
```

## 2. Leave Request Lifecycle (Flow)

The following sequence diagram illustrates the flow of a leave request from submission to final approval.

```mermaid
sequenceDiagram
    participant E as Employee
    participant F as Frontend
    participant B as Backend
    participant D as Database
    participant M as Operations Manager
    participant G as General Manager
    participant C as CEO

    E->>F: Fills Leave Form & Signs
    F->>B: POST /api/leave-requests
    B->>D: Create Request (Status: PENDING_OM)
    B-->>M: Email Notification (New Request)
    
    Note over M: Review Phase (OM)
    M->>F: Views Request
    F->>B: PATCH /api/leave-requests/:id/approve
    B->>D: Update Status (PENDING_GM)
    B-->>G: Email Notification (Level 2 Approval)

    Note over G: Review Phase (GM)
    G->>F: Views Request
    F->>B: PATCH /api/leave-requests/:id/approve
    B->>D: Update Status (PENDING_CEO)
    B-->>C: Email Notification (Final Approval)

    Note over C: Final Approval (CEO)
    C->>F: Views Request
    F->>B: PATCH /api/leave-requests/:id/approve
    B->>D: Update Status (APPROVED)
    B->>D: Update Employee Leave Balances
    B-->>E: Email Notification (Approved!)
```

## 3. Technology Stack Breakdown

| Layer | Technologies | Key Responsibilities |
| :--- | :--- | :--- |
| **Frontend** | React 18, TypeScript, Tailwind CSS, Shadcn/UI | UI/UX, State Management, PDF Generation (jsPDF), Client-side Validation. |
| **API Server** | Node.js, Express 5, TypeScript | Routing, Business Logic, RBAC (Role-Based Access Control), JWT Signing. |
| **Database** | Prisma (ORM), MS SQL Server | Data Persistence, Schema Migrations, Relationship Management. |
| **Security** | Passport.js (Google OAuth), JWT, bcrypt | User Authentication, Password Hashing, Session Management. |
| **Infrastructure** | Nodemailer, Nginx (Proxy), Windows Task Scheduler | Email Alerts, SSL Termination, Automated Database Backups. |

## 4. Key Security Flow (Authentication)

1. **Identification**: User selects "Login with Google" or enters Email/Password.
2. **Validation**: 
   - OAuth: Passport.js validates with Google servers.
   - Password: Bcrypt validates against hashed database password.
3. **Authorization**: Server issues a **JWT** containing User ID and Role.
4. **Persistent Access**: Frontend stores JWT and attaches it to the `Authorization` header for all subsequent API calls.
5. **Enforcement**: Backend middleware intercepts requests, decodes JWT, and verifies the user has the required role (e.g., `OPERATIONS_MANAGER`) to perform the action.

## 5. Deployment Topology

The application is optimized for deployment on a Windows Server environment using SQL Server.

```mermaid
graph LR
    Internet((Internet)) --> Nginx[Nginx Reverse Proxy]
    Nginx -->|SSL/Port 80 to 5173| FE_Server[Vite/Static Files Server]
    Nginx -->|API Proxy to Port 3001| BE_Server[Node.js Runtime]
    BE_Server -->|Prisma Client| SQL_Server[(MS SQL Server)]
    BE_Server -->|Local IP Detection| LAN[Company Intranet]
```
