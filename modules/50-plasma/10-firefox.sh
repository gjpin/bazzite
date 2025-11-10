#!/usr/bin/bash

# Set Firefox profile path
export FIREFOX_PROFILE_PATH=$(find ${HOME}/.var/app/org.mozilla.firefox/.mozilla/firefox -type d -name "*.default-release")

# Plasma specific configs
curl -sSL https://raw.githubusercontent.com/gjpin/bazzite/main/configs/firefox/plasma.js >> ${FIREFOX_PROFILE_PATH}/user.js

tee -a ${HOME}/.local/share/flatpak/overrides/org.mozilla.firefox << EOF

[Environment]
GTK_THEME=Breeze
EOF