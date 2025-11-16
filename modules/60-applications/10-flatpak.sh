#!/usr/bin/bash

# Install Flatpak runtimes and extensions
sudo flatpak install -y flathub org.freedesktop.Sdk//25.08
sudo flatpak install -y flathub org.freedesktop.Platform//25.08
sudo flatpak install -y flathub org.freedesktop.Sdk.Extension.llvm21//25.08