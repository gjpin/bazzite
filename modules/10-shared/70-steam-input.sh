#!/usr/bin/bash

# Steam devices udev rules
sudo curl -sSL https://raw.githubusercontent.com/ValveSoftware/steam-devices/master/60-steam-input.rules -o /etc/udev/rules.d/60-steam-input.rules
sudo curl -sSL https://raw.githubusercontent.com/ValveSoftware/steam-devices/master/60-steam-vr.rules -o /etc/udev/rules.d/60-steam-vr.rules