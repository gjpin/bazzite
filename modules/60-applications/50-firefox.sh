#!/usr/bin/bash

# Set Firefox profile path
export FIREFOX_PROFILE_PATH=$(find ${HOME}/.var/app/org.mozilla.firefox/.mozilla/firefox -type d -name "*.default-release")

# Import extensions
mkdir -p ${FIREFOX_PROFILE_PATH}/extensions
curl https://addons.mozilla.org/firefox/downloads/file/4003969/ublock_origin-latest.xpi -o ${FIREFOX_PROFILE_PATH}/extensions/uBlock0@raymondhill.net.xpi

# Import Firefox configs
curl https://raw.githubusercontent.com/gjpin/bazzite/main/configs/firefox/user.js -o ${FIREFOX_PROFILE_PATH}/user.js