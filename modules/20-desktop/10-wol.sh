#!/usr/bin/bash

# Enable WoL
# https://github.com/ublue-os/bazzite/blob/main/system_files/desktop/shared/usr/share/ublue-os/just/81-bazzite-fixes.just#L92
ujust toggle-wol enable
ujust toggle-wol force-enable

# Fix WoL
sudo rpm-ostree kargs --append-if-missing="xhci_hcd.quirks=270336"
