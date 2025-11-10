#!/usr/bin/bash

# Enable LUKS TPM unlock
# https://github.com/ublue-os/packages/blob/main/packages/ublue-os-luks/src/luks-enable-tpm2-autounlock
# https://github.com/ublue-os/packages/blob/main/packages/ublue-os-just/src/recipes/15-luks.just
ujust setup-luks-tpm-unlock