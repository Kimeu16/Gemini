import prisma from '../prisma/client';

async function run() {
    const user = await prisma.user.findFirst({
        where: { email: 'cholaronny@gmail.com' },
        include: { employee: true }
    });

    if (!user) {
        console.log('[INFO] Ronald Chola not found in User table!');
        return;
    }

    console.log(`[INFO] Found in User table:`);
    console.log(`  Name: ${user.name}`);
    console.log(`  Email: ${user.email}`);
    console.log(`  Role: ${user.role}`);
    console.log(`  Phone: ${user.phone}`);
    console.log(`  IsActive: ${user.isActive}`);
    console.log(`  IsTest: ${user.isTest}`);

    if (user.employee) {
        console.log(`[INFO] Found Employee Profile:`);
        console.log(`  Position: ${user.employee.position}`);
        console.log(`  Department: ${user.employee.department}`);
        console.log(`  Gender: ${user.employee.gender}`);
        console.log(`  Work Schedule: ${user.employee.workSchedule}`);
        console.log(`  Balances: ${user.employee.leaveBalances}`);
    } else {
        console.log('[INFO] Employee Profile not found for Ronald Chola!');
    }
}

run()
    .catch(console.error)
    .finally(async () => {
        await prisma.$disconnect();
    });
