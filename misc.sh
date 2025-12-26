#!/usr/bin/bash

################################################
##### Environment variables
################################################

tee -a ~/.config/environment.d/90-proton.conf << 'EOF'

PROTON_ENABLE_WAYLAND=1
PROTON_ENABLE_HDR=1
PROTON_FSR4_UPGRADE=1
SteamDeck=0
EOF

################################################
##### Bluetooth WoL
################################################

# References:
# https://wiki.archlinux.org/title/Bluetooth#Wake_from_suspend

log_info "Creating Bluetooth Wake-on-LAN udev rule"
sudo tee /etc/udev/rules.d/91-bluetooth-wakeup.rules << 'EOF'
ACTION=="add", SUBSYSTEM=="usb", DRIVERS=="usb", \
    ATTR{bDeviceClass}=="e0", \
    ATTR{bDeviceProtocol}=="01", \
    ATTR{bDeviceSubClass}=="01", \
ATTR{power/wakeup}="enabled"
EOF

log_success "Bluetooth WoL rule created"
log_end