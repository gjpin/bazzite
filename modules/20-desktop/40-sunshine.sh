# #!/usr/bin/bash

# # References:
# # https://www.answeroverflow.com/m/1276584307477057640
# # https://www.reddit.com/r/linux_gaming/comments/199ylqz/streaming_with_sunshine_from_virtual_screens/
# # https://git.linuxtv.org/v4l-utils.git/tree/utils/edid-decode/data
# # https://people.freedesktop.org/~imirkin/edid-decode/

# # Download EDID profiles for virtual displays
# # Displays with 4k60 + HDR + 1280x800 support
# sudo mkdir -p /usr/local/lib/firmware
# sudo cp ./configs/edid/dell-up2718q-dp /usr/local/lib/firmware/dell-up2718q-dp
# sudo cp ./configs/edid/samsung-q800t-hdmi2.1 /usr/local/lib/firmware/samsung-q800t-hdmi2.1

# # Load EDID profile
# # Replace dell-up2718q-dp with samsung-q800t-hdmi2.1 for HDMI
# sudo rpm-ostree kargs --append-if-missing="firmware_class.path=/usr/local/lib/firmware drm.edid_firmware=DP-2:dell-up2718q-dp video=DP-2:e"

# # Create Sunshine config directory
# mkdir -p ${HOME}/.config/sunshine

# # Import Sunshine apps
# if [[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* ]]; then
#     cp ./configs/sunshine/apps-gnome.json ${HOME}/.config/sunshine/apps.json
# fi

# # Enable Sunshine
# # https://github.com/ublue-os/bazzite/blob/main/system_files/desktop/shared/usr/share/ublue-os/just/82-bazzite-sunshine.just
# ujust setup-sunshine enable

# Access sunshine (localhost:47990) and configure access
# Disable virtual display: `gnome-randr --output DP-2 --off`
# Configure Moonlight clients