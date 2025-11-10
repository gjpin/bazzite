#!/usr/bin/bash

# Enable SSHD
ujust toggle-ssh enable

# Create authorized_keys file
touch ${HOME}/.ssh/authorized_keys