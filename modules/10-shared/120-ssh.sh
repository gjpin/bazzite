#!/usr/bin/bash
# Source logging functions
source lib/logging.sh

log_start

# Enable SSHD
# https://github.com/ublue-os/bazzite/blob/main/system_files/desktop/shared/usr/share/ublue-os/just/80-bazzite.just#L17

# Check if SSHD is already enabled (idempotent)
if systemctl is-enabled --quiet sshd.service 2>/dev/null; then
    log_info "SSHD service is already enabled, skipping."
    exit 0
fi

log_info "Enabling SSHD..."
ujust toggle-ssh enable

# Create authorized_keys file
touch ${HOME}/.ssh/authorized_keys

################################################
##### For reference only
################################################

# Enable SSHD
# sudo systemctl enable --now sshd

log_success "Module completed successfully"
log_end
