#!/bin/bash

# Function to display CPU usage
display_cpu() {
    clear
    echo "CPU Usage:"
    top -bn1 | grep "Cpu(s)" | sed "s/Cpu(s): //;s/ id.*//" | awk '{print "  " $1"%"}'
}

# Function to display memory usage
display_memory() {
    echo "Memory Usage:"
    free -h | grep Mem | awk '{print "  Total: " $2 ", Used: " $3 ", Free: " $4}'
}

# Function to display disk usage
display_disk() {
    echo "Disk Usage:"
    df -h | grep '^/dev/' | awk '{print "  " $1 ": " $5 " used"}'
}

# Function to display system load
display_load() {
    echo "System Load:"
    uptime | awk -F'load average:' '{ print "  " $2 }'
}

# Function to display the full dashboard
display_dashboard() {
    display_cpu
    display_memory
    display_disk
    display_load
}

# Main loop for real-time refresh
while true; do
    case "$1" in
        cpu)
            display_cpu
            ;;
        memory)
            display_memory
            ;;
        disk)
            display_disk
            ;;
        load)
            display_load
            ;;
        all)
            display_dashboard
            ;;
        *)
            echo "Usage: $0 {cpu|memory|disk|load|all}"
            exit 1
            ;;
    esac
    sleep 5
done
