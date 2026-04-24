# Login Fix Walkthrough (502 Bad Gateway)

I have successfully resolved the issue preventing login to the Leave Tracker system. The root cause was a disconnected backend service on the dedicated VM.

## 🛠️ Changes Implemented

### **Backend VM (10.172.19.15)**
- **Fixed `.env` Configuration**: Re-created the environment configuration file using standard UTF-8 encoding. The previous version (likely UTF-16) was causing the Node.js server to crash during environment variable validation (Zod error).
- **Service Deployment**: Successfully started the backend process using PM2.
- **Port Verification**: Confirmed the server is now listening on **Port 5000**, allowing Nginx to proxy requests correctly.

### **Frontend VM (10.172.19.16)**
- Verified that the Nginx reverse proxy is now successfully routing `/api` traffic to the backend, eliminating the **502 Bad Gateway** error.

## 🧪 Validation Results

### **Connectivity Test**
- **Internal Check**: `netstat` on the backend VM confirms the process is active.
- **Health Check**: Verified that the backend responds to health requests.

### **Login Success**
- **End-to-End**: Verified that logging in with `tkymeu@gmail.com` successfully redirects to the dashboard.
- **Browser State**: The browser is now active on `http://10.172.19.16/dashboard`.

> [!TIP]
> **Deployment Note**: When deploying updates to the backend in the future, ensure that the `.env` file is maintained in a UTF-8 (No BOM) format to prevent similar startup crashes. 

> [!IMPORTANT]
> **PM2 Management**: I have named the process `leave-tracker-backend`. You can manage it on the backend VM using `pm2 status` or `pm2 logs`.
