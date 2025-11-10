#!/usr/bin/bash

# Re-enable hot corners
gsettings set org.gnome.desktop.interface enable-hot-corners true

# Set accent color
gsettings set org.gnome.desktop.interface accent-color blue

# Set windows buttons
gsettings set org.gnome.desktop.wm.preferences button-layout menu:appmenu,close

# Set wallpaper
gsettings set org.gnome.desktop.background picture-uri file:///usr/share/backgrounds/gnome/blobs-d.svg
gsettings set org.gnome.desktop.background picture-uri-dark file:///usr/share/backgrounds/gnome/blobs-d.svg

# Set fonts
gsettings set org.gnome.desktop.interface font-name 'Adwaita Sans 10'
gsettings set org.gnome.desktop.interface document-font-name 'Adwaita Sans 10'
gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Adwaita Sans Bold 10'
gsettings set org.gnome.desktop.interface monospace-font-name 'Adwaita Mono Medium 10'

# Set dash applications
gsettings set org.gnome.shell favorite-apps "['org.gnome.Nautilus.desktop', 'org.mozilla.firefox.desktop', 'org.gnome.Ptyxis.desktop', 'org.gnome.TextEditor.desktop']"

# Calendar
gsettings set org.gnome.desktop.calendar show-weekdate true

# Increase check-alive-timeout to 30 seconds
gsettings set org.gnome.mutter check-alive-timeout 30000

# Nautilus
gsettings set org.gtk.Settings.FileChooser sort-directories-first true
gsettings set org.gnome.nautilus.icon-view default-zoom-level 'small-plus'

# Laptop specific
if cat /sys/class/dmi/id/chassis_type | grep 10 > /dev/null; then
  gsettings set org.gnome.desktop.interface show-battery-percentage true
  gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
  gsettings set org.gnome.desktop.peripherals.touchpad disable-while-typing false
fi