import prisma from '../prisma/client';
import bcrypt from 'bcrypt';
import { normalizePhone } from '../utils/phoneUtils';
import { APP_CONSTANTS } from '../utils/constants';

async function main() {
    const email = 'cholaronny@gmail.com';
    const name = 'Ronald Chola';
    const role = 'FIELD_ENGINEER';
    const department = 'MAINTENANCE';
    const gender = 'MALE';
    const workSchedule = 'MON_SAT';
    const annualBalance = 26;
    const sickBalance = 10;
    const phone = '254724945895';

    console.log(`Checking if user ${email} exists...`);
    const existingUser = await prisma.user.findUnique({
        where: { email }
    });

    if (existingUser) {
        console.log(`User ${email} already exists in database. Checking employee profile...`);
        const existingEmployee = await prisma.employee.findUnique({
            where: { userId: existingUser.id }
        });

        if (existingEmployee) {
            console.log(`Employee profile already exists for ${email}. Updating balances...`);
            let balances = { annual: annualBalance, sick: sickBalance, casual: 5, unpaid: 0 };
            try {
                if (existingEmployee.leaveBalances) {
                    balances = { ...balances, ...JSON.parse(existingEmployee.leaveBalances) };
                }
            } catch (e) {
                console.warn('Failed to parse existing balances, using defaults.');
            }
            balances.annual = annualBalance;
            balances.sick = sickBalance;

            await prisma.employee.update({
                where: { id: existingEmployee.id },
                data: {
                    position: role, // Position is the role/job title
                    department,
                    gender,
                    workSchedule,
                    leaveBalances: JSON.stringify(balances)
                }
            });
            console.log(`Employee profile updated successfully.`);
        } else {
            console.log(`Creating employee profile for existing user ${email}...`);
            await prisma.employee.create({
                data: {
                    userId: existingUser.id,
                    position: role,
                    department,
                    gender,
                    workSchedule,
                    leaveBalances: JSON.stringify({
                        annual: annualBalance,
                        sick: sickBalance,
                        casual: 5,
                        unpaid: 0
                    })
                }
            });
            console.log(`Employee profile created successfully.`);
        }
    } else {
        console.log(`Creating user and employee profile for ${email}...`);
        const normalizedPhone = normalizePhone(phone) || phone;
        const hashedPassword = await bcrypt.hash(normalizedPhone, APP_CONSTANTS.BCRYPT_ROUNDS);

        const newUser = await prisma.user.create({
            data: {
                name,
                email,
                role,
                phone: normalizedPhone,
                password: hashedPassword,
                emailVerified: false,
                isActive: true,
                isTest: false,
                requiresPasswordChange: true,
                employee: {
                    create: {
                        position: role,
                        department,
                        gender,
                        workSchedule,
                        leaveBalances: JSON.stringify({
                            annual: annualBalance,
                            sick: sickBalance,
                            casual: 5,
                            unpaid: 0
                        })
                    }
                }
            }
        });

        console.log(`✅ Successfully added employee ${name} with user ID: ${newUser.id}`);
    }
}

main()
    .catch((e) => {
        console.error('❌ Error executing script:', e);
        process.exit(1);
    })
    .finally(async () => {
        await prisma.$disconnect();
    });
