#!/usr/bin/bash

# Source logging functions
source lib/logging.sh

log_start
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