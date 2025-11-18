#!/usr/bin/bash

# Set hostname

# Get current hostname
CURRENT_HOSTNAME=$(hostnamectl hostname)

# Check if hostname already matches (idempotent)
if [ "${CURRENT_HOSTNAME}" = "${NEW_HOSTNAME}" ]; then
    echo "Hostname is already set to '${NEW_HOSTNAME}', skipping."
    exit 0
fi

echo "Setting hostname to '${NEW_HOSTNAME}'..."
sudo hostnamectl set-hostname --pretty "${NEW_HOSTNAME}"
sudo hostnamectl set-hostname --static "${NEW_HOSTNAME}"