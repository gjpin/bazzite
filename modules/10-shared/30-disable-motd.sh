#!/usr/bin/bash

# Disable MOTD

# Check if MOTD is already disabled (idempotent)
if [ -f "${HOME}/.config/no-show-user-motd" ]; then
    echo "User MOTD is already disabled, skipping."
    exit 0
fi

echo "Disabling user MOTD..."
ujust toggle-user-motd