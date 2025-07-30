# bazzite


## Format and encrypt extra drive
```bash
# Delete old partition layout and re-read partition table
sudo wipefs -af /dev/nvme1n1
sudo parted --script /dev/nvme1n1 mklabel gpt

# Partition disk and re-read partition table
sudo parted --script /dev/nvme1n1 \
  mkpart primary 1MiB 100% \
  name 1 LUKSDATA \
  set 1 lvm off

# Re-read partitions
sudo partprobe /dev/nvme1n1

# Encrypt and open LUKS partition
sudo cryptsetup luksFormat \
    --type luks2 \
    --hash sha512 \
    --use-random \
    /dev/disk/by-partlabel/LUKSDATA

sudo cryptsetup luksOpen /dev/disk/by-partlabel/LUKSDATA data

# Format partition to BTRFS
sudo mkfs.btrfs -L data /dev/mapper/data

# Mount disk
sudo mount /dev/mapper/data /mnt

# Create sub-volumes
sudo btrfs subvolume create /mnt/@data

# Unmount disk
sudo umount /mnt

# Auto-mount
sudo tee -a /etc/fstab << EOF

# data disk
/dev/mapper/data   /var/mnt/data   btrfs   subvol=@data,noatime,compress=zstd,x-systemd.requires=systemd-cryptsetup@data.service 0 0
EOF

sudo tee -a /etc/crypttab << EOF

data UUID=$(sudo blkid -s UUID -o value /dev/nvme1n1p1) none luks
EOF

sudo systemctl daemon-reload

# Auto unlock
sudo systemd-cryptenroll --wipe-slot=tpm2 --tpm2-device=auto --tpm2-pcrs=7+14 /dev/nvme1n1p1

# Change ownership to user
sudo umount /mnt
sudo chown -R $USER:$USER /var/mnt/data
```