# Local Database Setup Walkthrough

We have successfully configured a local SQL Server environment using Docker to ensure you can continue testing and development even when the production VM is offline.

## Changes Made

### 1. New Docker Configuration
- Created [docker-compose.yml](file:///c:/Apps/Leave%20Tracker/docker-compose.yml) in the root directory.
- This launches a SQL Server 2022 container locally.

### 2. Dual-Environment .env
- Modified [server/.env](file:///c:/Apps/Leave%20Tracker/server/.env) to include both the **Remote Production VM** and **Local Docker** URLs.
- Provided a simple way to toggle between them.

### 3. Localization & Seeding
- Pushed the current Prisma schema to the local database.
- Fixed type validation errors in [seed-prod.js](file:///c:/Apps/Leave%20Tracker/server/seed-prod.js) (stringifying `leaveBalances`).
- Seeded the local database with default users (`ceo@company.com`, `om@company.com`, `gm@company.com`).

## How to use

### Switching to Production VM
When the VM is back online, simply open `server/.env` and:
1.  Comment out the **Local Docker** URL.
2.  Uncomment the **Remote VM** URL.
3.  Restart your server.

### Starting/Stopping the Local DB
- **Stop**: `docker compose down` in the project root.
- **Start**: `docker compose up -d` in the project root.

## Verification Results

- **Docker**: Container `leave-tracker-db` is running on port `1433`.
- **Seeding**: Successfully created CEO, OM, and GM records.
- **Server Connectivity**: Verified that the server connects to `localhost:1433` and correctly initializes.

> [!SUCCESS]
> The backend server is now healthy and connected to your local database. Your team's test accounts are ready for login.
