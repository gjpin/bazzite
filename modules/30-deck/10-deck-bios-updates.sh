#!/usr/bin/bash

# Enable Steam Deck bios/firmware updates
# https://github.com/ublue-os/bazzite/blob/main/system_files/deck/shared/usr/share/ublue-os/just/85-bazzite-image.just#L41

# Check if jupiter-biosupdate.service is already enabled (idempotent)
if systemctl is-enabled --quiet jupiter-biosupdate.service 2>/dev/null; then
    echo "Steam Deck BIOS updates service is already enabled, skipping."
    exit 0
fi

echo "Enabling Steam Deck BIOS/firmware updates..."
ujust enable-deck-bios-firmware-updates