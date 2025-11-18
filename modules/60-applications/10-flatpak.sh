#!/usr/bin/bash

# Install Flatpak runtimes and extensions
sudo flatpak install -y flathub org.freedesktop.Platform.ffmpeg-full//25.08
sudo flatpak install -y flathub org.freedesktop.Platform.GStreamer.gstreamer-vaapi//25.08
sudo flatpak install -y flathub org.freedesktop.Platform.GL.default//25.08-extra
sudo flatpak install -y flathub org.freedesktop.Platform.GL32.default//25.08-extra
sudo flatpak install -y flathub org.freedesktop.Sdk//25.08
sudo flatpak install -y flathub org.freedesktop.Platform//25.08

# Install MangoHud
sudo flatpak install -y flathub org.freedesktop.Platform.VulkanLayer.MangoHud//25.08

# Install Gamescope
sudo flatpak install -y flathub org.freedesktop.Platform.VulkanLayer.gamescope//25.08

# Add private repo
sudo flatpak remote-add --if-not-exists private https://gjpin.github.io/flatpaks/index.flatpakrepo