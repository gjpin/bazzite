#!/usr/bin/bash

# Create common directories
mkdir -p \
    ${HOME}/ssh \
    ${HOME}/.local/share/themes \
    ${HOME}/.local/bin \
    ${HOME}/.local/share/flatpak/overrides \
    ${HOME}/.config/systemd/user

# Create WireGuard folder
sudo mkdir -p /etc/wireguard
sudo chmod 700 /etc/wireguard