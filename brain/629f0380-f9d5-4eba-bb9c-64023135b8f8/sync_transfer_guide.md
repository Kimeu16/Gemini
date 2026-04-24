# 🛠️ Re-connecting your Cloud Sync on Vercel

Since your **Apps Script URL** is stored securely in your browser's local memory, it won't automatically follow you to the new Vercel site. You need to "tell" the new site where your Google Sheet is.

### **Step 1: Get your URL from the Local App**
1.  Open your **Local App** (the one currently running on your computer).
2.  On the sidebar, scroll down to the **Support** section and click **"Settings"**.
3.  You will see a field labeled **"Apps Script Web App URL"**.
4.  Copy that entire URL (it starts with `https://script.google.com/macros/s/...`).

### **Step 2: Go to your New Vercel Site**
1.  Open your browser and go to your **newly deployed Vercel URL** (e.g., `master-three.vercel.app`).
2.  Just like before, click **"Settings"** on the sidebar.
3.  You'll notice the URL field is **empty** because it's a new environment.

### **Step 3: Paste and Save**
1.  Paste the URL you copied into the **Apps Script Web App URL** box.
2.  Click the blue **"Save Settings"** button.
3.  You should see a green success message: *"Settings saved successfully!"*

### **✅ All Done!**
Now, when you go back to your **Site Inventory** on Vercel and edit a site, it will correctly talk to your Google Sheet just like it does locally.
