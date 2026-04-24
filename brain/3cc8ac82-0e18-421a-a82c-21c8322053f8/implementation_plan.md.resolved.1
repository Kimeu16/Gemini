# Sequential Document IDs Implementation

The goal translates to creating perfectly sequential visual IDs like `A01`, `A02`, `A03` for leave requests, while maintaining the secure backend UUIDs linking.

## Proposed Changes

### Prisma Schema (Database)
#### [MODIFY] schema.prisma
- Add a new `requestNumber Int @default(autoincrement()) @map("request_number")` field to the `LeaveRequest` model.
- Because we use SQL Server, this will perform an `ALTER TABLE ADD request_number INT IDENTITY(1,1)` underneath, safely numbering existing rows sequentially (1, 2, 3...).

### Backend API
#### [MODIFY] Server Types & Repositories
- Regenerate the Prisma Client. No manual backend changes should theoretically be needed since our API probably returns full rows to the frontend, but I will verify that `requestNumber` flows properly in `leaveRequestController` queries if they restrict selected fields.

### Frontend UI & PDF Generator
#### [MODIFY] Types
- Add `requestNumber: number;` to the `LeaveRequest` TS interface.

#### [MODIFY] Requests.tsx & corporatePdf.ts
- Update the PDF layout and UI modal to extract `requestNumber`, pad it to string, and prepend an "A". (e.g., Request number 1 becomes "A01").
- Final ID format will be **`ADC-LVE-202604-A01`**, **`ADC-LVE-202604-A02`**, etc. 

---
> [!IMPORTANT]
> **User Review Required**
> 1. By executing this plan, I will run a Prisma database migration. Since we use `prisma migrate dev` (which preserves data), it is completely safe.
> 2. Existing requests will automatically be assigned historic sequence numbers starting at 1. Is starting the prefix with letter `A` for all numbers acceptable? (e.g. `A01`, `A42`).

**Reply with "yes" or anything similar to approve this plan so I can begin making changes!**
