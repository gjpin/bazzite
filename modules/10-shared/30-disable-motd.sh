#!/usr/bin/bash
# Source logging functions
source lib/logging.sh

log_start

# Disable MOTD

# Check if MOTD is already disabled (idempotent)
if [ -f "${HOME}/.config/no-show-user-motd" ]; then
    log_info "User MOTD is already disabled, skipping."
    exit 0
fi

log_info "Disabling user MOTD..."
ujust toggle-user-motd

log_success "Module completed successfully"
log_end
