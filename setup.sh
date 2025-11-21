#!/usr/bin/bash

# Source logging functions
source lib/logging.sh

log_start

################################################
##### Set variables
################################################

log_info "Prompting for hostname"
read -p "Hostname: " NEW_HOSTNAME
export NEW_HOSTNAME
log_info "Hostname set to: $NEW_HOSTNAME"

################################################
##### Shared configurations
################################################

log_info "Starting shared configurations"
# Shared
for module in modules/10-shared/*.sh; do
  if [ -f "$module" ]; then
    log_info "Running shared module: $module"
    if bash "$module"; then
      log_success "Completed $module"
    else
      log_error "Failed $module"
      exit 1
    fi
  fi
done
log_success "Shared configurations completed"

################################################
##### Device type specific configurations
################################################

# Desktop
if cat /sys/class/dmi/id/chassis_type | grep 3 > /dev/null; then
  log_info "Detected desktop chassis, starting desktop configurations"
  for module in modules/20-desktop/*.sh; do
    if [ -f "$module" ]; then
      log_info "Running desktop module: $module"
      if bash "$module"; then
        log_success "Completed $module"
      else
        log_error "Failed $module"
        exit 1
      fi
    fi
  done
  log_success "Desktop configurations completed"
else
  log_info "Not a desktop chassis, skipping desktop modules"
fi

# Steam Deck
SYS_ID="$(/usr/libexec/hwsupport/sysid)"
if [[ ":Jupiter:" =~ ":$SYS_ID:" || ":Galileo:" =~ ":$SYS_ID:" ]]; then
  log_info "Detected Steam Deck (SYS_ID: $SYS_ID), starting Steam Deck configurations"
  for module in modules/30-deck/*.sh; do
    if [ -f "$module" ]; then
      log_info "Running Steam Deck module: $module"
      if bash "$module"; then
        log_success "Completed $module"
      else
        log_error "Failed $module"
        exit 1
      fi
    fi
  done
  log_success "Steam Deck configurations completed"
else
  log_info "Not a Steam Deck (SYS_ID: $SYS_ID), skipping Steam Deck modules"
fi

################################################
##### Applications
################################################

log_info "Starting applications configurations"
# Applications
for module in modules/40-applications/*.sh; do
  if [ -f "$module" ]; then
    log_info "Running applications module: $module"
    if bash "$module"; then
      log_success "Completed $module"
    else
      log_error "Failed $module"
      exit 1
    fi
  fi
done
log_success "Applications configurations completed"

################################################
##### Emulation
################################################

log_info "Starting emulation configurations"
# Emulation
for module in modules/50-emulation/*.sh; do
  if [ -f "$module" ]; then
    log_info "Running emulation module: $module"
    if bash "$module"; then
      log_success "Completed $module"
    else
      log_error "Failed $module"
      exit 1
    fi
  fi
done
log_success "Emulation configurations completed"

################################################
##### Desktop environment specific configurations
################################################

# Install and configure desktop environment
if [[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* ]]; then
  log_info "Detected GNOME desktop environment, starting GNOME configurations"
  for module in modules/60-gnome/*.sh; do
    if [ -f "$module" ]; then
      log_info "Running GNOME module: $module"
      if bash "$module"; then
        log_success "Completed $module"
      else
        log_error "Failed $module"
        exit 1
      fi
    fi
  done
  log_success "GNOME configurations completed"
elif [[ "$XDG_CURRENT_DESKTOP" == *"KDE"* ]]; then
  log_info "Detected KDE/Plasma desktop environment, starting Plasma configurations"
  for module in modules/70-plasma/*.sh; do
    if [ -f "$module" ]; then
      log_info "Running Plasma module: $module"
      if bash "$module"; then
        log_success "Completed $module"
      else
        log_error "Failed $module"
        exit 1
      fi
    fi
  done
  log_success "Plasma configurations completed"
else
  log_info "No supported desktop environment detected (XDG_CURRENT_DESKTOP: $XDG_CURRENT_DESKTOP), skipping desktop-specific modules"
fi

log_end