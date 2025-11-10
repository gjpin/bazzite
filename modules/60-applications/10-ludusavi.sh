#!/usr/bin/bash

# Install Ludusavi
sudo flatpak install -y flathub com.github.mtkennerly.ludusavi
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