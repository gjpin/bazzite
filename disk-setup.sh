#!/bin/bash

# Check if both arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <disk_name> <mount_name>"
    echo "Example: $0 nvme1n1 data"
    exit 1
fi

DISK_NAME="$1"
MOUNT_NAME="$2"
DISK_PATH="/dev/${DISK_NAME}"
MOUNT_PATH="/var/mnt/${MOUNT_NAME}"

# Determine partition suffix (nvme/loop/mmcblk use 'p1', others use '1')
if [[ "${DISK_NAME}" =~ ^(nvme|loop|mmcblk) ]]; then
    PARTITION_PATH="${DISK_PATH}p1"
else
    PARTITION_PATH="${DISK_PATH}1"
fi

# Delete old partition layout and re-read partition table
sudo wipefs -af "${DISK_PATH}"
sudo parted --script "${DISK_PATH}" mklabel gpt

# Partition disk and re-read partition table
sudo parted --script "${DISK_PATH}" \
  mkpart primary 1MiB 100% \
  name 1 LUKSDATA \
  set 1 lvm off

# Re-read partitions
sudo partprobe "${DISK_PATH}"

# Encrypt and open LUKS partition
sudo cryptsetup luksFormat \
    --type luks2 \
    --hash sha512 \
    --use-random \
    /dev/disk/by-partlabel/LUKSDATA

sudo cryptsetup luksOpen /dev/disk/by-partlabel/LUKSDATA "${MOUNT_NAME}"

# Format partition to BTRFS
sudo mkfs.btrfs -L "${MOUNT_NAME}" "/dev/mapper/${MOUNT_NAME}"

# Create the mountpoint
sudo mkdir -p "${MOUNT_PATH}"

# Auto-mount disk
sudo tee -a /etc/fstab << EOF

# ${MOUNT_NAME} disk
/dev/mapper/${MOUNT_NAME}   ${MOUNT_PATH}   btrfs   noatime,compress=zstd,x-systemd.requires=systemd-cryptsetup@${MOUNT_NAME}.service 0 0
EOF

# Auto unlock disk
sudo tee -a /etc/crypttab << EOF

${MOUNT_NAME} UUID=$(sudo blkid -s UUID -o value ${PARTITION_PATH}) none luks
EOF

# Reload systemd config
sudo systemctl daemon-reload

# Auto unlock
sudo systemd-cryptenroll --wipe-slot=tpm2 --tpm2-device=auto --tpm2-pcrs=7+14 "${PARTITION_PATH}"

# Change ownership to user
sudo mount "${MOUNT_PATH}"
sudo chown -R $USER:$USER "${MOUNT_PATH}"