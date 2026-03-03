#!/bin/bash
# Container monitoring script - logs CPU and memory usage with timestamp

LOG_DIR="/opt/container-monitor/logs"
LOG_FILE="$LOG_DIR/container-stats.log"

mkdir -p "$LOG_DIR"

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# Get Docker container stats (no stream, one snapshot)
# Format: container name, cpu %, mem usage, mem limit
STATS=$(docker stats --no-stream --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}" 2>/dev/null)

if [ -n "$STATS" ]; then
    echo "=== $TIMESTAMP ===" >> "$LOG_FILE"
    echo "$STATS" >> "$LOG_FILE"
    echo "" >> "$LOG_FILE"
fi
