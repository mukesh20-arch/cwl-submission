# DevOps Internship Project Submission

This is my submission for the DevOps internship assignment. I’ve put each part in its own folder with a README that explains what I did, the commands I ran, and how I checked that it worked.

## Walkthrough video

 walkthrough: [Watch on Google Drive](https://drive.google.com/file/d/10Aec9nFTNGE9Zzfgb4dhwLUiyvwszZn3/view?usp=sharing)

## What’s in the repo

- **Server + SSH** — Ubuntu, OpenSSH, and passwordless login using SSH keys.
- **Docker + web app** — Docker installed, a custom HTML page, a Dockerfile using nginx, and the app running on port 8000.
- **Monitoring** — A script that logs container CPU and memory with a timestamp, run every minute by cron; logs are under `/opt/container-monitor/logs`.
- **Log access** — A separate user for monitoring; only that user and root can access `/opt/container-monitor`.
- **Firewall** — UFW: SSH allowed only from one IP, HTTP and port 8000 allowed, then enabled and checked.

The Docker stuff is in the folder with the Dockerfile and index.html; the monitoring script is in the monitoring folder. All of this was done on Ubuntu. When you run the commands, swap in your own `server_ip` and the IP you want to allow for SSH (e.g. `YOUR_OFFICE_OR_HOME_IP`).
