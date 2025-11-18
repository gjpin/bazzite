#!/usr/bin/bash

# Make Network Manager not block boot

# Check if service is already disabled (idempotent)
if ! systemctl is-enabled --quiet NetworkManager-wait-online.service 2>/dev/null; then
    echo "NetworkManager-wait-online.service is already disabled, skipping."
    exit 0
fi

echo "Disabling NetworkManager-wait-online.service..."
sudo systemctl disable --now NetworkManager-wait-online.service