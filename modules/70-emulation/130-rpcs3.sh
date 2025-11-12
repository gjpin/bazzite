#!/usr/bin/bash

# Instal RPCS3
sudo flatpak install -y flathub net.rpcs3.RPCS3

# Import Flatpak overrides
cp ./configs/flatpak/net.rpcs3.RPCS3 ${HOME}/.local/share/flatpak/overrides/net.rpcs3.RPCS3