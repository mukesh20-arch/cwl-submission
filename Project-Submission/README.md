# DevOps Internship Project Submission

This repo is my submission for the DevOps internship assignment. Each folder has a README with what I did, the commands I used, and how I verified things.

## What’s in the repo

- Server setup and SSH key-based authentication (Ubuntu, OpenSSH, passwordless login).
- Docker install, a custom HTML page, Dockerfile with nginx, and running the app on port 8000.
- A script that logs container CPU and memory with timestamps, run every minute via cron; logs go under `/opt/container-monitor/logs`.
- A dedicated user for monitoring, with ownership and permissions on `/opt/container-monitor` so only that user (and root) can access the logs.
- UFW firewall: SSH only from one IP, HTTP and port 8000 allowed, then enable and verify.

The Docker and web app folder has the Dockerfile and index.html; the monitoring folder has the monitor script. Everything was done on Ubuntu. Replace placeholders like `server_ip` and `YOUR_OFFICE_OR_HOME_IP` with your own values when you run the commands.
