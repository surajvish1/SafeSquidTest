# SafeSquidTest
Bash Script is for SafeSquid Devops engineer technical tasks.

Task 1: Monitoring System resources for a proxy server.

Overview
This Bash script provides real-time monitoring of essential system resources including CPU usage, memory usage, disk usage, and system load. It offers a straightforward way to view these metrics with customizable display options.

Features
CPU Usage: Current CPU usage percentage.
Memory Usage: Total, used, and free memory.
Disk Usage: Disk usage for mounted filesystems.
System Load: Current system load averages.

Prerequisites
Bash Shell: The script is intended for use with Bash.

Required Commands: Ensure the following commands are available:
top
grep
sed
awk
free
df
uptime

Installation
Save the Script: Download and save it as Task1.sh.

Set Execute Permission:

chmod +x Task1.sh
Usage
Run the script with various options to monitor specific metrics. The script updates every 5 seconds.

Commands
CPU Usage:

./Task1.sh cpu
Displays current CPU usage.

Memory Usage:
./Task1.sh memory
Shows memory usage statistics.

Disk Usage:

./Task1.sh disk
Lists disk usage for mounted filesystems.

System Load:

./Task1.sh load
Provides system load averages.

All Metrics:

./Task1.sh all
Displays CPU, memory, disk, and load metrics.

Example
To monitor all metrics in real-time:

./Task1.sh all

Stopping the Script
To exit the script, press Ctrl + C.

Troubleshooting
Command Not Found: Ensure required commands (top, grep, sed, awk, free, df, uptime) are installed.
Permissions: You may need appropriate permissions to execute certain commands

------------------------------------------------------------------------------------------------

Task 2: Script for Automating Security Audits and Server Hardening Linux Servers

Step1) Make script excutable:
chmod +x task2.sh

Step2) Execute the script with root privileges to ensure it can perform all necessary checks and modifications.
sudo ./task2.sh

Step3): The script logs all its actions to /var/log/task2.log. Review this log to understand what changes were made and any issues that were detected.
cat /var/log/task2.log



