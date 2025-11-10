#!/usr/bin/bash

# Make Network Manager not block boot
sudo systemctl disable --now NetworkManager-wait-online.service