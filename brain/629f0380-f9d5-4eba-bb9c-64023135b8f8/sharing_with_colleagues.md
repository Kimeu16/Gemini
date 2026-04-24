# 👥 Sharing the App with Colleagues

I've updated the code so that your app can now use a **shared secret** for the Google Sheets connection. This means your colleagues won't have to go into Settings—the app will "just work" for them.

### **Step 1: Get your Apps Script URL**
1.  Open your app and go to **System Settings**.
2.  Copy the **Apps Script Web App URL**.

### **Step 2: Add to Vercel**
This is the "magic" step that shares the connection with everyone:
1.  Go to your **Vercel Dashboard**.
2.  Click on your **Master** project.
3.  Go to the **Settings** tab (the one in the Vercel menu, not in your app).
4.  Click on **Environment Variables** in the left sidebar.
5.  Add a new variable:
    *   **Key**: `VITE_GOOGLE_APPS_SCRIPT_URL`
    *   **Value**: (Paste your Apps Script URL here)
6.  Click **Save**.

### **Step 3: Redeploy**
Environment variables are baked into the app when it's built, so you need to redeploy once:
1.  Go to the **Deployments** tab in Vercel.
2.  Click the three dots `...` on the latest deployment and select **Redeploy**.

---

### **🌟 How it works now:**
- **For your colleagues**: When they open the link, the app will automatically use the `VITE_GOOGLE_APPS_SCRIPT_URL` you provided. The "Sync Not Configured" warning will be gone!
- **For you (Overrides)**: If you ever want to use a *different* sheet for just yourself, you can still paste a new URL into the app's **System Settings**—the app will always prioritize your local "Settings" over the shared one in Vercel.
