#!/usr/bin/bash

# Install Discord
sudo flatpak install -y flathub com.discordapp.Discord
cp ./configs/flatpak/com.discordapp.Discord ${HOME}/.local/share/flatpak/overrides/com.discordapp.Discord