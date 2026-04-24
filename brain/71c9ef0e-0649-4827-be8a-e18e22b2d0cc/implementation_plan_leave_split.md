# Implementation Plan: Separating Sick and Annual Leave Balances

The goal is to properly divide the single "Annual Leave Balance" value uploaded from the CSV into a dedicated **Sick Leave** bucket and a true **Annual Leave** bucket.

## The Logic

Based on the company policy, everyone receives 10 Sick Leave days out of their base yearly allocation. Any days beyond those 10 are technically their accrued Annual Leave from this year plus any carry-forward from previous years.

I propose we run a script that applies the following logic to every employee in the database:

1. **Get their Current Uploaded Total** (e.g., Kiprotich Davis = 47)
2. **Apply Policy Filter**:
   - **If the Total is 10 or more:**
     - Set Sick Leave = 10
     - Set Annual Leave = Total - 10
     *(Example for Davis: Sick = 10, Annual = 37)*
   - **If the Total is less than 10 (e.g., a brand new hire with 4 days):**
     - Set Sick Leave = 4 (or total available)
     - Set Annual Leave = 0
     *(We prioritize filling the Sick Leave bucket first, as it is a base requirement).*

## User Review Required
> [!WARNING]
> Please review the logic for employees with **less than 10 total days**. Is it correct to allocate all their available days to Sick Leave and leave their Annual Leave at 0? Or should they be guaranteed 10 Sick Leave days regardless, meaning their Annual Leave would dip into the negatives? 

## Proposed Execution

I will create a backend migration script (`split-leave-balances.ts`) that:
1. Iterates through all 56 Employee records.
2. Reads the current `annual` balance (which currently represents the CSV total).
3. Applies the mathematical split.
4. Saves explicitly defined `annual` and `sick` values back to the `leaveBalances` JSON object.

Once approved, I will run the script directly on the production database.
