#!/usr/bin/bash

# Install ProtonPlus
flatpak install -y flathub com.vysp3r.ProtonPlus

# Import Flatpak overrides
cp ./configs/flatpak/com.vysp3r.ProtonPlus ${HOME}/.local/share/flatpak/overrides/com.vysp3r.ProtonPlus