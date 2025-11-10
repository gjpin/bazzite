#!/usr/bin/bash

################################################
##### Set variables
################################################

read -p "Hostname: " NEW_HOSTNAME
export NEW_HOSTNAME

################################################
##### Shared configurations
################################################

# Shared
for module in modules/10-shared/*.sh; do
  if [ -f "$module" ]; then
    echo "Running shared module: $module"
    bash "$module"
  fi
done

################################################
##### Device type specific configurations
################################################

# Desktop
if cat /sys/class/dmi/id/chassis_type | grep 3 > /dev/null; then
  for module in modules/20-desktop/*.sh; do
    if [ -f "$module" ]; then
      echo "Running desktop module: $module"
      bash "$module"
    fi
  done
fi

# Steam Deck
SYS_ID="$(/usr/libexec/hwsupport/sysid)"
if [[ ":Jupiter:" =~ ":$SYS_ID:" || ":Galileo:" =~ ":$SYS_ID:" ]]; then
  for module in modules/30-deck/*.sh; do
    if [ -f "$module" ]; then
      echo "Running Steam Deck module: $module"
      bash "$module"
    fi
  done
fi

################################################
##### Desktop environment specific configurations
################################################

# Install and configure desktop environment
if [[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* ]]; then
  for module in modules/40-gnome/*.sh; do
    if [ -f "$module" ]; then
      echo "Running Gnome module: $module"
      bash "$module"
    fi
  done
elif [[ "$XDG_CURRENT_DESKTOP" == *"KDE"* ]]; then
  for module in modules/50-plasma/*.sh; do
    if [ -f "$module" ]; then
      echo "Running Plasma module: $module"
      bash "$module"
    fi
  done
fi

################################################
##### Applications
################################################

# Applications
for module in modules/60-applications/*.sh; do
  if [ -f "$module" ]; then
    echo "Running applications module: $module"
    bash "$module"
  fi
done