#!/usr/bin/bash
# Source logging functions
source lib/logging.sh

log_start

# Enable Steam Deck bios/firmware updates
# https://github.com/ublue-os/bazzite/blob/main/system_files/deck/shared/usr/share/ublue-os/just/85-bazzite-image.just#L41

# Check if jupiter-biosupdate.service is already enabled (idempotent)
if systemctl is-enabled --quiet jupiter-biosupdate.service 2>/dev/null; then
    log_info "Steam Deck BIOS updates service is already enabled, skipping."
    exit 0
fi

log_info "Enabling Steam Deck BIOS/firmware updates..."
ujust enable-deck-bios-firmware-updates

log_success "Module completed successfully"
log_end
