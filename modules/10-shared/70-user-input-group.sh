#!/usr/bin/bash

# Add user to input group
# https://github.com/ublue-os/bazzite/blob/main/system_files/desktop/shared/usr/share/ublue-os/just/80-bazzite.just#L193

# Check if user is already in input group (idempotent)
if id -nG "$USER" | grep -qw "input"; then
    echo "User is already in the input group, skipping."
    exit 0
fi

echo "Adding user to input group..."
ujust add-user-to-input-group

################################################
##### For reference only
################################################

# if ! grep -q "input" /etc/group; then
#     sudo bash -c 'grep "input" /lib/group >> /etc/group'
# fi
# sudo usermod -a -G input $USER