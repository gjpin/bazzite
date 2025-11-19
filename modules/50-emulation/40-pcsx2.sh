#!/usr/bin/bash

# Instal PCSX2
sudo flatpak install -y flathub net.pcsx2.PCSX2

# Import Flatpak overrides
cp ./configs/flatpak/net.pcsx2.PCSX2 ${HOME}/.local/share/flatpak/overrides/net.pcsx2.PCSX2

# Create PCSX2 directories
mkdir -p ${HOME}/Games/Emulation/roms/ps2
mkdir -p ${HOME}/Games/Emulation/bios/ps2
mkdir -p ${HOME}/Games/Emulation/saves/pcsx2
mkdir -p ${HOME}/Games/Emulation/states/pcsx2
mkdir -p ${HOME}/Games/Emulation/data/pcsx2/{snapshots,cache,covers,logs,textures,videos}

# Import PCSX2 configurations
mkdir -p ${HOME}/.var/app/net.pcsx2.PCSX2/config/PCSX2/inis
envsubst < ./configs/pcsx2/PCSX2.ini | tee ${HOME}/.var/app/net.pcsx2.PCSX2/config/PCSX2/inis/PCSX2.ini