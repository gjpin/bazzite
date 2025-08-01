#!/usr/bin/bash

################################################
##### Set variables
################################################

read -p "Hostname: " NEW_HOSTNAME
export NEW_HOSTNAME

################################################
##### General
################################################

# Set hostname
sudo hostnamectl set-hostname --pretty "${NEW_HOSTNAME}"
sudo hostnamectl set-hostname --static "${NEW_HOSTNAME}"

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

# Make NM not block boot
sudo systemctl disable --now NetworkManager-wait-online.service

# Enable BTRFS dedup
# https://github.com/ublue-os/bazzite/blob/main/system_files/desktop/shared/usr/share/ublue-os/just/85-bazzite-image.just#L4
ujust enable-deduplication

# Disable MOTD
ujust toggle-user-motd

# Install Decky Loader
# https://github.com/ublue-os/bazzite/blob/main/system_files/desktop/shared/usr/share/ublue-os/just/80-bazzite.just#L274
ujust setup-decky install

# Enable LUKS TPM unlock
# https://github.com/ublue-os/packages/blob/main/packages/ublue-os-luks/src/luks-enable-tpm2-autounlock
# https://github.com/ublue-os/packages/blob/main/packages/ublue-os-just/src/recipes/15-luks.just
ujust setup-luks-tpm-unlock

# Enable automounting
# https://github.com/ublue-os/bazzite/blob/main/system_files/desktop/shared/usr/share/ublue-os/just/80-bazzite.just#L201
ujust enable-automounting

# Add user to input group
# https://github.com/ublue-os/bazzite/blob/main/system_files/desktop/shared/usr/share/ublue-os/just/80-bazzite.just#L193
ujust add-user-to-input-group

################################################
##### Device type specific configurations
################################################

# Desktop
if cat /sys/class/dmi/id/chassis_type | grep 3 > /dev/null; then
  # Enable WoL
  # https://github.com/ublue-os/bazzite/blob/main/system_files/desktop/shared/usr/share/ublue-os/just/81-bazzite-fixes.just#L92
  ujust toggle-wol force-enable
  
  # Fix WoL
  sudo rpm-ostree kargs --append-if-missing="xhci_hcd.quirks=270336"
  
  # Full AMD GPU control
  if lspci | grep "VGA" | grep "AMD" > /dev/null; then
    sudo rpm-ostree kargs --append-if-missing="amdgpu.ppfeaturemask=0xffffffff"
  fi

  # Install LACT
  # https://github.com/ublue-os/bazzite/blob/main/system_files/desktop/shared/usr/share/ublue-os/just/82-bazzite-apps.just#L28
  ujust install-lact

  # Enable SSHD and create authorized_keys file
  ujust toggle-ssh enable
  touch ${HOME}/.ssh/authorized_keys
fi

# Steam Deck
SYS_ID="$(/usr/libexec/hwsupport/sysid)"
if [[ ":Jupiter:" =~ ":$SYS_ID:" || ":Galileo:" =~ ":$SYS_ID:" ]]; then
  # Enable Steam Deck bios/firmware updates
  # https://github.com/ublue-os/bazzite/blob/main/system_files/deck/shared/usr/share/ublue-os/just/85-bazzite-image.just#L41
  ujust enable-deck-bios-firmware-updates
fi

################################################
##### Sunshine
################################################

# References:
# https://www.answeroverflow.com/m/1276584307477057640
# https://www.reddit.com/r/linux_gaming/comments/199ylqz/streaming_with_sunshine_from_virtual_screens/
# https://git.linuxtv.org/v4l-utils.git/tree/utils/edid-decode/data
# https://people.freedesktop.org/~imirkin/edid-decode/

# Desktop
if cat /sys/class/dmi/id/chassis_type | grep 3 > /dev/null; then

  # Download EDID profiles for virtual displays
  # Displays with 4k60 + HDR + 1280x800 support
  sudo mkdir -p /usr/local/lib/firmware
  sudo curl https://raw.githubusercontent.com/gjpin/bazzite/main/configs/edid/dell-up2718q-dp -o /usr/local/lib/firmware/dell-up2718q-dp
  sudo curl https://raw.githubusercontent.com/gjpin/bazzite/main/configs/edid/samsung-q800t-hdmi2.1 -o /usr/local/lib/firmware/samsung-q800t-hdmi2.1

  # Load EDID profile
  # Replace dell-up2718q-dp with samsung-q800t-hdmi2.1 for HDMI
  sudo rpm-ostree kargs --append-if-missing="firmware_class.path=/usr/local/lib/firmware drm.edid_firmware=DP-2:dell-up2718q-dp video=DP-2:e"

  # Enable Sunshine
  # https://github.com/ublue-os/bazzite/blob/main/system_files/desktop/shared/usr/share/ublue-os/just/82-bazzite-sunshine.just
  ujust setup-sunshine enable

  # Create Sunshine config directory
  mkdir -p ${HOME}/.config/sunshine

  # Import Sunshine apps
  if [[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* ]]; then
    curl https://raw.githubusercontent.com/gjpin/bazzite/main/configs/sunshine/apps-gnome.json -o ${HOME}/.config/sunshine/apps.json
  fi
fi

################################################
##### Updates
################################################

# Updater helper
tee ${HOME}/.local/bin/update-all << EOF
#!/usr/bin/bash

################################################
##### System and firmware
################################################

# Update bazzite
ujust update

# Update firmware
sudo fwupdmgr refresh
sudo fwupdmgr update

################################################
##### Flatpaks
################################################

# Update Flatpak apps
flatpak update -y

################################################
##### General
################################################

# Clean up unused resources
ujust clean-system
EOF

chmod +x ${HOME}/.local/bin/update-all

################################################
##### Firefox
################################################

# Set Firefox profile path
export FIREFOX_PROFILE_PATH=$(find ${HOME}/.var/app/org.mozilla.firefox/.mozilla/firefox -type d -name "*.default-release")

# Import extensions
mkdir -p ${FIREFOX_PROFILE_PATH}/extensions
curl https://addons.mozilla.org/firefox/downloads/file/4003969/ublock_origin-latest.xpi -o ${FIREFOX_PROFILE_PATH}/extensions/uBlock0@raymondhill.net.xpi

# Import Firefox configs
curl https://raw.githubusercontent.com/gjpin/bazzite/main/configs/firefox/user.js -o ${FIREFOX_PROFILE_PATH}/user.js

################################################
##### Applications
################################################

# Install Heroic Games Launcher
flatpak install -y flathub com.heroicgameslauncher.hgl

# Create directories for Heroic games and prefixes
mkdir -p ${HOME}/Games/Heroic/Prefixes

# Install and start Syncthing
brew install syncthing
brew services start syncthing

################################################
##### Ludusavi
################################################

# Install Ludusavi
flatpak install -y flathub com.github.mtkennerly.ludusavi
curl https://raw.githubusercontent.com/gjpin/bazzite/main/configs/flatpak/com.github.mtkennerly.ludusavi -o ${HOME}/.local/share/flatpak/overrides/com.github.mtkennerly.ludusavi

# Import Ludusavi config
mkdir -p ${HOME}/.var/app/com.github.mtkennerly.ludusavi/config/ludusavi
curl https://raw.githubusercontent.com/gjpin/bazzite/main/configs/ludusavi/config.yaml | envsubst > ${HOME}/.var/app/com.github.mtkennerly.ludusavi/config/ludusavi/config.yaml

# Set automatic backups
# https://github.com/mtkennerly/ludusavi/blob/master/docs/help/backup-automation.md
tee ~/.config/systemd/user/ludusavi-backup.service << 'EOF'
[Unit]
Description="Ludusavi backup"

[Service]
ExecStart=/usr/bin/flatpak run com.github.mtkennerly.ludusavi backup --force
EOF

tee ~/.config/systemd/user/ludusavi-backup.timer << 'EOF'
[Unit]
Description="Ludusavi backup timer"

[Timer]
OnCalendar=*:0/5
Unit=ludusavi-backup.service

[Install]
WantedBy=timers.target
EOF

systemctl --user enable ${HOME}/.config/systemd/user/ludusavi-backup.timer

################################################
##### Desktop Environment
################################################

# Install and configure desktop environment
if [[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* ]]; then
  ./gnome.sh
elif [[ "$XDG_CURRENT_DESKTOP" == *"KDE"* ]]; then
  ./plasma.sh
fi