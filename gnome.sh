#!/usr/bin/bash

################################################
##### General
################################################

# Install Adwaita theme for Steam
# https://github.com/ublue-os/bazzite/blob/main/system_files/desktop/shared/usr/share/ublue-os/just/82-bazzite-apps.just#L28
# ujust install-adwaita-for-steam

################################################
##### Firefox
################################################

# Set Firefox profile path
export FIREFOX_PROFILE_PATH=$(find ${HOME}/.var/app/org.mozilla.firefox/.mozilla/firefox -type d -name "*.default-release")

# Install Firefox Gnome theme
mkdir -p ${FIREFOX_PROFILE_PATH}/chrome
git clone https://github.com/rafaelmardojai/firefox-gnome-theme.git ${FIREFOX_PROFILE_PATH}/chrome/firefox-gnome-theme
echo '@import "firefox-gnome-theme/userChrome.css"' > ${FIREFOX_PROFILE_PATH}/chrome/userChrome.css
echo '@import "firefox-gnome-theme/userContent.css"' > ${FIREFOX_PROFILE_PATH}/chrome/userContent.css
curl -sSL https://raw.githubusercontent.com/gjpin/bazzite/main/configs/firefox/gnome.js >> ${FIREFOX_PROFILE_PATH}/user.js

# Firefox theme updater
tee -a ${HOME}/.local/bin/update-all << 'EOF'

################################################
##### Firefox
################################################

# Update Firefox theme
FIREFOX_PROFILE_PATH=$(realpath ${HOME}/.var/app/org.mozilla.firefox/.mozilla/firefox/*.default-release)
git -C ${FIREFOX_PROFILE_PATH}/chrome/firefox-gnome-theme pull
EOF

################################################
##### GTK theme
################################################

# Install adw-gtk3 flatpak
flatpak install -y flathub org.gtk.Gtk3theme.adw-gtk3
flatpak install -y flathub org.gtk.Gtk3theme.adw-gtk3-dark

# Download and install latest adw-gtk3 release
URL=$(curl -s https://api.github.com/repos/lassekongo83/adw-gtk3/releases/latest | awk -F\" '/browser_download_url.*.tar.xz/{print $(NF-1)}')
curl -sSL ${URL} -O
tar -xf adw-*.tar.xz -C ${HOME}/.local/share/themes/
rm -f adw-*.tar.xz

# Set adw-gtk3 theme
gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

# GTK theme updater
tee -a ${HOME}/.local/bin/update-all << 'EOF'

################################################
##### GTK theme
################################################

URL=$(curl -s https://api.github.com/repos/lassekongo83/adw-gtk3/releases/latest | awk -F\" '/browser_download_url.*.tar.xz/{print $(NF-1)}')
curl -sSL ${URL} -O
rm -rf ${HOME}/.local/share/themes/adw-gtk3*
tar -xf adw-*.tar.xz -C ${HOME}/.local/share/themes/
rm -f adw-*.tar.xz
EOF

################################################
##### Ptyxis shortcuts
################################################

# Configure ptyxis shortcuts
gsettings set org.gnome.Ptyxis.Shortcuts move-next-tab '<Control>Tab'
gsettings set org.gnome.Ptyxis.Shortcuts move-previous-tab '<Shift><Control>Tab'
gsettings set org.gnome.Ptyxis.Shortcuts close-tab '<Control>w'
gsettings set org.gnome.Ptyxis.Shortcuts new-tab '<Control>t'
gsettings set org.gnome.Ptyxis.Shortcuts undo-close-tab '<Control><Shift>t'

################################################
##### Gnome shortcuts
################################################

# Windows management
gsettings set org.gnome.desktop.wm.keybindings close "['<Shift><Super>q']"

# Screenshots
gsettings set org.gnome.shell.keybindings show-screenshot-ui "['<Shift><Super>s']"

# Applications
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/']"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Super>Return'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'ptyxis'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'ptyxis'

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ binding '<Super>E'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ command 'nautilus'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ name 'nautilus'

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ binding '<Shift><Control>Escape'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ command 'flatpak run io.missioncenter.MissionCenter'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ name 'io.missioncenter.MissionCenter'

# Change alt+tab behaviour
gsettings set org.gnome.desktop.wm.keybindings switch-applications "@as []"
gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward "@as []"
gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Alt>Tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward "['<Shift><Alt>Tab']"

# Switch to workspace
gsettings set org.gnome.shell.keybindings switch-to-application-1 "@as []"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "['<Super>1']"
gsettings set org.gnome.shell.keybindings switch-to-application-2 "@as []"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 "['<Super>2']"
gsettings set org.gnome.shell.keybindings switch-to-application-3 "@as []"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 "['<Super>3']"
gsettings set org.gnome.shell.keybindings switch-to-application-4 "@as []"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 "['<Super>4']"

# Move window to workspace
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-1 "['<Shift><Super>exclam']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-2 "['<Shift><Super>at']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-3 "['<Shift><Super>numbersign']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-4 "['<Shift><Super>dollar']"

################################################
##### Gnome UI / UX changes
################################################

# Set windows buttons
gsettings set org.gnome.desktop.wm.preferences button-layout menu:appmenu,close

# Disable blur-my-shell extension
gnome-extensions disable blur-my-shell@aunetx

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