#!/usr/bin/bash

# Install Decky Loader
# https://github.com/ublue-os/bazzite/blob/main/system_files/desktop/shared/usr/share/ublue-os/just/91-bazzite-decky.just

# Check if Decky Loader is already installed (idempotent)
if [[ -f /etc/systemd/system/multi-user.target.wants/plugin_loader.service ]]; then
    echo "Decky Loader is already installed, skipping."
    exit 0
fi

echo "Installing Decky Loader..."
ujust setup-decky install