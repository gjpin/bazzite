#!/usr/bin/bash

# Full AMD GPU control
if lspci | grep "VGA" | grep "AMD" > /dev/null; then
  sudo rpm-ostree kargs --append-if-missing="amdgpu.ppfeaturemask=0xffffffff"
fi
