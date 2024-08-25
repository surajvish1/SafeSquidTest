#!/bin/bash

# Constants
LOGFILE="/var/log/security_hardening.log"
IPV4_CHECK="ipv4_check"
IPV6_CHECK="ipv6_check"
PUBLIC_IP_CHECK="public_ip_check"
HARDENING_CHECK="hardening_check"

# Function to log messages
log() {
    local message="$1"
    echo "$(date): $message" | tee -a $LOGFILE
}

# Function to perform a security audit
perform_audit() {
    log "Starting security audit..."

    # Check for common vulnerabilities
    check_unauthorized_users
    check_for_ssh_root_login
    check_for_weak_permissions
    check_for_unnecessary_services
    check_for_software_updates
}

# Function to apply hardening measures
apply_hardening() {
    log "Applying hardening measures..."

    # Implement hardening measures
    disable_root_login
    set_ssh_permit_root_login
    set_file_permissions
    disable_unnecessary_services
    apply_software_updates
}

# Function to check unauthorized users
check_unauthorized_users() {
    log "Checking for unauthorized users..."
    # List users with UID < 1000 (usually system accounts)
    awk -F':' '$3 < 1000 { print $1 " has UID: " $3 }' /etc/passwd
}

# Function to check SSH root login
check_for_ssh_root_login() {
    log "Checking SSH root login..."
    grep -E "^PermitRootLogin" /etc/ssh/sshd_config
}

# Function to check for weak file permissions
check_for_weak_permissions() {
    log "Checking file permissions..."
    find / -perm /007 -type f 2>/dev/null
}

# Function to check for unnecessary services
check_for_unnecessary_services() {
    log "Checking for unnecessary services..."
    systemctl list-unit-files --state=enabled
}

# Function to check for software updates
check_for_software_updates() {
    log "Checking for software updates..."
    apt list --upgradable 2>/dev/null  # For Debian/Ubuntu
    yum check-update 2>/dev/null        # For RHEL/CentOS
}

# Function to disable root login
disable_root_login() {
    log "Disabling root login..."
    sed -i '/^PermitRootLogin/s/yes/no/' /etc/ssh/sshd_config
    systemctl restart sshd
}

# Function to set SSH PermitRootLogin to 'no'
set_ssh_permit_root_login() {
    log "Setting SSH PermitRootLogin to 'no'..."
    sed -i '/^PermitRootLogin/s/.*/PermitRootLogin no/' /etc/ssh/sshd_config
    systemctl restart sshd
}

# Function to set file permissions
set_file_permissions() {
    log "Setting file permissions..."
    chmod 600 /etc/shadow
    chmod 600 /etc/gshadow
}

# Function to disable unnecessary services
disable_unnecessary_services() {
    log "Disabling unnecessary services..."
    systemctl disable telnet
    systemctl disable rsh
}

# Function to apply software updates
apply_software_updates() {
    log "Applying software updates..."
    apt update && apt upgrade -y  # For Debian/Ubuntu
    yum update -y                 # For RHEL/CentOS
}

# Function to check IPv4 configuration
check_ipv4() {
    log "Checking IPv4 configuration..."
    ip a | grep inet
}

# Function to check IPv6 configuration
check_ipv6() {
    log "Checking IPv6 configuration..."
    ip a | grep inet6
}

# Function to identify public vs. private IP
check_ip_type() {
    log "Checking IP types..."
    ip a | grep inet | awk '{print $2}' | while read ip; do
        if [[ "$ip" =~ ^10\.|^172\.16\.|^192\.168\. ]]; then
            log "$ip is a private IP address."
        else
            log "$ip is a public IP address."
        fi
    done
}

# Main script logic
case "$1" in
    "audit")
        perform_audit
        ;;
    "harden")
        apply_hardening
        ;;
    "ipv4")
        check_ipv4
        ;;
    "ipv6")
        check_ipv6
        ;;
    "iptype")
        check_ip_type
        ;;
    *)
        echo "Usage: $0 {audit|harden|ipv4|ipv6|iptype}"
        exit 1
        ;;
esac
