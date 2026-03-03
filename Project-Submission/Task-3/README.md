# Container Monitoring Automation

## What I Did

I created a directory for the monitor under `/opt/container-monitor/logs`, wrote a script that logs Docker container CPU and memory usage with a timestamp, and set up a cron job so it runs every minute and appends to a log file in that directory.

## monitor.sh Script

The script:

- Uses `/opt/container-monitor/logs` for the log directory and creates it if needed.
- Writes to `/opt/container-monitor/logs/container-stats.log`.
- Adds a timestamp for each run.
- Runs `docker stats --no-stream` to get one snapshot of CPU and memory per container.
- Appends the output to the log file.

So each minute you get a timestamp plus a table of container names, CPU percent, and memory usage. The script is in `monitor.sh` in this folder.

## Cron Configuration

Run the script every minute:

```bash
sudo crontab -e
```

Add this line (adjust the path if your script is elsewhere):

```
* * * * * /opt/container-monitor/monitor.sh
```

So the script has to live at `/opt/container-monitor/monitor.sh` on the server. Copy it there and make it executable:

```bash
sudo mkdir -p /opt/container-monitor/logs
sudo cp monitor.sh /opt/container-monitor/monitor.sh
sudo chmod +x /opt/container-monitor/monitor.sh
```

If the cron runs as root, it will have permission to run `docker stats`. If you run it as another user, that user must be in the `docker` group.

## Commands Used

```bash
# Create directory structure
sudo mkdir -p /opt/container-monitor/logs

# Copy script and make executable
sudo cp monitor.sh /opt/container-monitor/monitor.sh
sudo chmod +x /opt/container-monitor/monitor.sh

# Add cron job (crontab -e then add the line above)
sudo crontab -e
```

To confirm it’s working, wait a minute or two and check the log:

```bash
cat /opt/container-monitor/logs/container-stats.log
```

You should see timestamped blocks with container stats. That’s how I verified the monitoring process.
