#!/usr/bin/bash

# Add user to input group
# https://github.com/ublue-os/bazzite/blob/main/system_files/desktop/shared/usr/share/ublue-os/just/80-bazzite.just#L193
ujust add-user-to-input-group

################################################
##### For reference only
################################################

# if ! grep -q "input" /etc/group; then
#     sudo bash -c 'grep "input" /lib/group >> /etc/group'
# fi
# sudo usermod -a -G input $USER