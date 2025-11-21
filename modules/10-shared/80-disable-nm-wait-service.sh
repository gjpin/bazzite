#!/usr/bin/bash
# Source logging functions
source lib/logging.sh

log_start

# Make Network Manager not block boot

# Check if service is already disabled (idempotent)
if ! systemctl is-enabled --quiet NetworkManager-wait-online.service 2>/dev/null; then
    log_info "NetworkManager-wait-online.service is already disabled, skipping."
    exit 0
fi

log_info "Disabling NetworkManager-wait-online.service..."
sudo systemctl disable --now NetworkManager-wait-online.service

log_success "Module completed successfully"
log_end
