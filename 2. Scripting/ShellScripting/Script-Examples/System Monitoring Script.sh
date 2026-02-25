#!/bin/bash
cpu_threshold=90
mem_threshold=90
cpu_idle=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}')
cpu_usage=$(echo "100 - $cpu_idle" | bc)

# Memory usage (using grep and awk)
mem_usage=$(free | grep Mem | awk '{printf "%.2f", $3/$2 * 100}')
if (( $(echo "$cpu_usage > $cpu_threshold" | bc -l) )) || (( $(echo "$mem_usage > $mem_threshold" | bc -l) )); then
    echo "High CPU or memory usage detected!"
    # Send alert here
fi