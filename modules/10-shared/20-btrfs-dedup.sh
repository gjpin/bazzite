#!/usr/bin/bash

# Enable BTRFS dedup
# https://github.com/ublue-os/bazzite/blob/main/system_files/desktop/shared/usr/share/ublue-os/just/85-bazzite-image.just#L4

# Check if the timer is already enabled (idempotent)
if systemctl is-enabled --quiet btrfs-dedup@var-home.timer 2>/dev/null; then
    echo "BTRFS deduplication timer is already enabled, skipping."
    exit 0
fi

echo "Enabling BTRFS deduplication..."
ujust enable-deduplication