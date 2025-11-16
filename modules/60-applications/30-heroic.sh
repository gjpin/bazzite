#!/usr/bin/bash

# Install Heroic Games Launcher
sudo flatpak install -y flathub com.heroicgameslauncher.hgl
cp ./configs/flatpak/com.heroicgameslauncher.hgl ${HOME}/.local/share/flatpak/overrides/com.heroicgameslauncher.hgl

# Create directories for Heroic games and prefixes
mkdir -p ${HOME}/Games/Heroic/Prefixes