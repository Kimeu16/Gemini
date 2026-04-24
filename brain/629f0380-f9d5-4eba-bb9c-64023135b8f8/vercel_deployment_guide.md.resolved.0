# 🚀 Vercel Deployment Guide

Now that your project is on GitHub with all the fixes, you can deploy it to Vercel in just a few clicks.

### **Step 1: Connect to Vercel**
1.  Go to [Vercel.com](https://vercel.com) and log in.
2.  Click the **"Add New..."** button and select **"Project"**.
3.  If you haven't already, link your GitHub account.
4.  Find your project repository: **`Kimeu16/Master`** and click **Import**.

### **Step 2: Configure & Deploy**
1.  Vercel will auto-detect that this is a **Vite** project.
2.  **Framework Preset**: Let it stay as `Vite`.
3.  **Build Command**: Should be `npm run build` (automatic).
4.  **Output Directory**: Should be `dist` (automatic).
5.  Click **Deploy**! 🎊

### **Step 3: Post-Deployment Setup**
Because we use `localStorage` to keep your Google Sheets connection secure, you'll need to transfer your settings to the new URL:
1.  Open your **New Vercel URL** once the deployment finishes.
2.  Navigate to the **System Settings** (from the sidebar).
3.  Paste your **Google Apps Script URL** (the same one you used locally).
4.  Click **Save Settings**.

---

### **💡 Pro Tip: Keeping it in Sync**
If you ever make more changes locally, just run these commands to update your live site:
```powershell
git add .
git commit -m "Describe your changes"
git push
```
Vercel will detect the push and **automatically update** your live site!
