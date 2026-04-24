# Troubleshooting: Local vs Production Discrepancy

The user can see the changes on `localhost:8080` (local build) but not on the production server `10.172.19.16`. This suggests that either the production server is serving from a different directory than expected, or there are multiple Nginx instances/configurations in play.

## Research Findings
- **Local Deployment**: Confirmed working.
- **Production Deployment**: Script reported success, but content is stale.
- **Potential Issue**: The production VM `10.172.19.16` might be Linux (CentOS), while the script assumes Windows, OR the Nginx configuration is not being reloaded from the correct path.

## Proposed Investigation Steps

### 1. Identify Remote OS & Environment
- Run a simple `uname -a` or `ver` to confirm if `10.172.19.16` is Windows or Linux.
- Locate the *actual* active Nginx configuration on the remote VM.

### 2. Verify Serving Path
- Create a unique "canary" file on the remote server: `echo "DEPLOY_VERSION_0408" > C:\leave-tracker\dist\version.txt` (or appropriate path).
- Attempt to access `http://10.172.19.16/version.txt` to verify if that directory is indeed the root.

### 3. Log Inspection
- Inspect the Nginx error logs on the remote VM to see if reloads are failing.

## Open Questions
- **OS Confirmation**: Is `10.172.19.16` definitely a Windows server? The `nginx-frontend.conf` in the repo mentions CentOS, which is a major red flag.
- **Vite Hash**: Does the `index.html` on the server reference the new asset hashes (e.g., `Requests-BysiR4ph.js`) or old ones?
