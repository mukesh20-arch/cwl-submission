# Secure Monitoring Logs

## What I Did

I created a dedicated user for the monitoring setup, gave that user full ownership of `/opt/container-monitor`, and restricted access for everyone else so only the monitoring user (and root) can read or write the logs.

## Commands Used

```bash
# Create the monitoring user (no login shell, no home dir)
sudo useradd -r -s /bin/false containermonitor

# Give ownership of the whole monitoring directory to that user
sudo chown -R containermonitor:containermonitor /opt/container-monitor

# Restrict: owner has read/write/execute, group and others have nothing
sudo chmod -R 700 /opt/container-monitor
```

So `containermonitor` owns everything under `/opt/container-monitor` and has full access; other users get no access. Root can still access it.

## Verification

```bash
# Check ownership
ls -la /opt/container-monitor
ls -la /opt/container-monitor/logs
```

You should see `containermonitor` as owner and group, and permissions like `drwx------` (700) on the directory.

```bash
# Try reading the log as a normal user (should get permission denied)
sudo -u nobody cat /opt/container-monitor/logs/container-stats.log
```

That should fail with permission denied. The cron job that runs the monitor script needs to run as root (or as a user that can run docker and that you’ve given access to this directory). If you run the script as root, root can write to `/opt/container-monitor` after we changed ownership; to have the script run as `containermonitor`, you’d need to give that user permission to run `docker` (e.g. add it to the docker group) and schedule the cron under that user. Keeping the cron as root and just locking down who else can read the logs is enough.

So: dedicated user created, ownership set, permissions restricted, and verified with `ls` and a quick test read as another user.
