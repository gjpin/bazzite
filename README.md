# bazzite
0. Update Bazzite `ujust update` and reboot
1. Run setup.sh
2. (HTPC only) Access sunshine (localhost:47990) and configure access
3. (HTPC only) Configure secondary drive in Steam and make it the default
4. (HTPC only) Copy SSH public key to $HOME/.ssh/authorized_keys
5. Reboot
6. (HTPC only) Disable virtual display: `gnome-randr --output DP-2 --off`
7. Copy wireguard key to /etc/wireguard and enable connection: `sudo nmcli con import type wireguard file /etc/wireguard/wg0.conf`
8. Configure Moonlight clients
9. Configure Heroic:
   * General -> Set folder for new wine prefix: $HOME/Games/Heroic/Prefixes
   * General -> Automatically update games
   * General -> Add games to Steam automatically
   * Game Defaults -> WinePrefix folder: $HOME/Games/Heroic/Prefixes
   * Add Heroic to Steam (Steam -> Add a Game -> Heroic)
10. In Steam Game Mode:
   * Install Decky Loader plugins
      * SteamGridDB
   * (HTPC only) Settings -> Display -> Maximum game resolution -> 3840x2160

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

# Create the mountpoint
sudo mkdir -p /var/mnt/data

# Auto-mount disk
sudo tee -a /etc/fstab << EOF

# data disk
/dev/mapper/data   /var/mnt/data   btrfs   noatime,compress=zstd,x-systemd.requires=systemd-cryptsetup@data.service 0 0
EOF

# Auto unlock disk
sudo tee -a /etc/crypttab << EOF

data UUID=$(sudo blkid -s UUID -o value /dev/nvme1n1p1) none luks
EOF

# Reload systemd config
sudo systemctl daemon-reload

# Auto unlock
sudo systemd-cryptenroll --wipe-slot=tpm2 --tpm2-device=auto --tpm2-pcrs=7+14 /dev/nvme1n1p1

# Change ownership to user
sudo mount /var/mnt/data
sudo chown -R $USER:$USER /var/mnt/data
```