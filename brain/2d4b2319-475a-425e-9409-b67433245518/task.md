# Login Debug & Fix Checklist

- [x] Run diagnostic probe on Frontend and Backend VMs (`probe-vms.ps1`)
- [x] Verify Backend process (Server) is running on `10.172.19.15`
- [x] Check if Backend is listening on port 5000
- [x] Inspect Nginx error logs on `10.172.19.16`
- [x] Restart/Start Backend service if necessary
- [x] Verify connectivity via `Invoke-WebRequest`
- [x] Final browser login test
