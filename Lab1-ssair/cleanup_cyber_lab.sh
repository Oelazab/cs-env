#!/bin/bash

# Script: cleanup_cyber_lab1.sh
# Description: Removes all artifacts created by the cybersecurity lab setup script
# Must be run as root

# Ensure script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root. Use sudo." >&2
    exit 1
fi

echo "Starting Cybersecurity Lab Cleanup..."
echo "This will remove all lab artifacts in 10 seconds..."
echo "Press Ctrl+C now to abort if needed."
sleep 10

echo "Removing user accounts..."
userdel -r hacker 2>/dev/null
userdel -r cryptominer 2>/dev/null
userdel -r employee 2>/dev/null

echo "Cleaning up files..."
rm -f /opt/secret.message
rm -f /tmp/backdoor.sh
rm -rf /var/lib/.hidden_data
rm -f /var/log/backdoor.log
rm -f /var/log/xmrig.log
rm -f /usr/local/bin/xmrig

echo "Restoring permissions..."
chmod o-w /etc/passwd

echo "Killing lab processes..."
pkill -f "/tmp/backdoor.sh"
pkill -f "/usr/local/bin/xmrig"

echo "Cleaning cron jobs..."
crontab -r -u hacker 2>/dev/null
crontab -r -u cryptominer 2>/dev/null

echo "Cleaning SSH keys..."
rm -rf /home/hacker/.ssh
rm -rf /home/cryptominer/.ssh
rm -rf /home/employee/.ssh

echo "Cleaning sudo privileges..."
rm -f /etc/sudoers.d/10-hacker

echo "Cleaning log entries..."
# Note: Instead of deleting logs, we'll just mark them
echo "----- LAB CLEANUP PERFORMED BELOW THIS LINE -----" >> /var/log/auth.log

echo "Verifying cleanup..."
echo "Remaining artifacts (should be empty):"
ls -la /opt/secret.message 2>/dev/null
ls -la /tmp/backdoor.sh 2>/dev/null
ls -la /var/lib/.hidden_data 2>/dev/null

echo ""
echo "Lab environment cleanup complete!"
echo "System is now ready for the next session."