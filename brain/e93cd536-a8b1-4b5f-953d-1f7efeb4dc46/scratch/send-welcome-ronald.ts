import { sendEmail, emailTemplates } from '../services/email.service';

async function main() {
    const email = 'cholaronny@gmail.com';
    const name = 'Ronald Chola';
    const role = 'FIELD_ENGINEER';
    const department = 'MAINTENANCE';

    console.log(`Sending welcome email to ${name} <${email}>...`);
    const template = emailTemplates.welcomeNewEmployee(name, email, role, department);

    const success = await sendEmail({
        to: email,
        subject: template.subject,
        html: template.html
    });

    if (success) {
        console.log(`✅ Welcome email successfully sent to ${email}`);
    } else {
        console.error(`❌ Failed to send welcome email to ${email}`);
        process.exit(1);
    }
}

main()
    .catch((e) => {
        console.error('❌ Error executing script:', e);
        process.exit(1);
    });
