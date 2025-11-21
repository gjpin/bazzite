#!/usr/bin/bash
# Source logging functions
source lib/logging.sh

log_start

# Set hostname

# Get current hostname
CURRENT_HOSTNAME=$(hostnamectl hostname)

# Check if hostname already matches (idempotent)
if [ "${CURRENT_HOSTNAME}" = "${NEW_HOSTNAME}" ]; then
    log_info "Hostname is already set to '${NEW_HOSTNAME}', skipping."
    log_end
    exit 0
fi

log_info "Setting hostname to '${NEW_HOSTNAME}'..."
sudo hostnamectl set-hostname --pretty "${NEW_HOSTNAME}"
sudo hostnamectl set-hostname --static "${NEW_HOSTNAME}"

log_success "Hostname set successfully"
log_end
