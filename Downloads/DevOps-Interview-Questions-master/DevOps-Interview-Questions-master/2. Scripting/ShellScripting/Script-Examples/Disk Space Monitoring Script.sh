# Write a script to monitor disk space usage and send alerts if thresholds are exceeded.

#!/bin/bash
threshold=90
disk_usage=$(df -h | grep "/dev/sda1" | awk '{print $5}' | tr -d '%')
if [ "$disk_usage" -gt "$threshold" ]; then
    echo "Disk space usage exceeded $threshold%"
    # Send alert here
fi


#!/bin/bash
threshold=90
current_diskSpace=$(df -h | awk '{print $5}')
if [ "$current_diskSpace" -gt $threshold ];then
  echo "Disk Space usage exceeded $threshold%"
fi