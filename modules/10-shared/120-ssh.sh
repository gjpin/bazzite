#!/usr/bin/bash

# Enable SSHD
# https://github.com/ublue-os/bazzite/blob/main/system_files/desktop/shared/usr/share/ublue-os/just/80-bazzite.just#L17

# Check if SSHD is already enabled (idempotent)
if systemctl is-enabled --quiet sshd.service 2>/dev/null; then
    echo "SSHD service is already enabled, skipping."
    exit 0
fi

echo "Enabling SSHD..."
ujust toggle-ssh enable

# Create authorized_keys file
touch ${HOME}/.ssh/authorized_keys

################################################
##### For reference only
################################################

# Enable SSHD
# sudo systemctl enable --now sshd