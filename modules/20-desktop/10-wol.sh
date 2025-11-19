#!/usr/bin/bash

# Enable WoL
# https://github.com/ublue-os/bazzite/blob/main/system_files/desktop/shared/usr/share/ublue-os/just/81-bazzite-fixes.just#L92

# Check if WoL is already enabled (idempotent)
INTERFACE=$(ip route | grep default | awk '{print $5}' | head -1)
if [ -n "$INTERFACE" ]; then
    WOL_STATUS=$(sudo ethtool "$INTERFACE" 2>/dev/null | grep -P "^\s+Wake-on" | awk '{print $2}')
    if [[ "$WOL_STATUS" =~ [gm] ]]; then
        echo "Wake-on-LAN is already enabled on $INTERFACE, skipping."
        exit 0
    fi
fi

echo "Enabling Wake-on-LAN..."
ujust toggle-wol enable
ujust toggle-wol force-enable

# Fix WoL
sudo rpm-ostree kargs --append-if-missing="xhci_hcd.quirks=270336"
