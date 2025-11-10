#!/usr/bin/bash

# Configure ptyxis shortcuts
gsettings set org.gnome.Ptyxis.Shortcuts move-next-tab '<Control>Tab'
gsettings set org.gnome.Ptyxis.Shortcuts move-previous-tab '<Shift><Control>Tab'
gsettings set org.gnome.Ptyxis.Shortcuts close-tab '<Control>w'
gsettings set org.gnome.Ptyxis.Shortcuts new-tab '<Control>t'
gsettings set org.gnome.Ptyxis.Shortcuts undo-close-tab '<Control><Shift>t'