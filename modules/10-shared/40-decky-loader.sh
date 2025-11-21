#!/usr/bin/bash
# Source logging functions
source lib/logging.sh

log_start

# Install Decky Loader
# https://github.com/ublue-os/bazzite/blob/main/system_files/desktop/shared/usr/share/ublue-os/just/91-bazzite-decky.just

# Check if Decky Loader is already installed (idempotent)
if [[ -f /etc/systemd/system/multi-user.target.wants/plugin_loader.service ]]; then
    log_info "Decky Loader is already installed, skipping."
    exit 0
fi

log_info "Installing Decky Loader..."
ujust setup-decky install

log_success "Module completed successfully"
log_end
