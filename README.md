# Quickstart
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

# Emulation
|**Platform**|**Standalone**|**RetroArch Core**|**Default**|
|:---|:---|:---|:---|
|PSX|N/A|[Beetle PSX HW](https://docs.libretro.com/library/beetle_psx_hw/)|RetroArch|
|PS2|[PCSX2](https://github.com/PCSX2/pcsx2)|[LRPS2](https://docs.libretro.com/library/lrps2/)|Standalone|
|PS3|[RPCS3](https://github.com/RPCS3/rpcs3)|N/A|Standalone|
|PSP|[PPSSPP](https://github.com/hrydgard/ppsspp)|[PPSSPP](https://docs.libretro.com/library/ppsspp/)|Standalone|
|GameCube / Wii|[Dolphin](https://github.com/dolphin-emu/dolphin)|[Dolphin](https://docs.libretro.com/library/dolphin/)|Standalone|
|GBA|[mGBA](https://github.com/mgba-emu/mgba)|[mGBA](https://docs.libretro.com/library/mgba/)|RetroArch|
|SNES|[Snes9x](https://github.com/snes9xgit/snes9x)|[Snes9x](https://docs.libretro.com/library/snes9x/)|RetroArch|
|DS|[melonDS](net.kuribo64.melonDS)|[melonDS](https://docs.libretro.com/library/melonds_ds/)|Standalone|
|3DS|[Azahar](https://github.com/azahar-emu/azahar)|[Citra](https://docs.libretro.com/library/citra/)|Standalone|
|Wii U|[CEMU](https://github.com/cemu-project/Cemu)|N/A|Standalone|
|Genesis / Mega Drive|N/A|[Genesis Plus GX](https://github.com/libretro/Genesis-Plus-GX)|RetroArch|
|Dreamcast|[Flycast](https://github.com/flyinghead/flycast)|[Flycast](https://docs.libretro.com/library/flycast/)|Standalone|
|Saturn|N/A|[Beetle Saturn](https://docs.libretro.com/library/beetle_saturn/)|RetroArch|

## Port forward syncthing to _this machine
```bash
ssh -L 8385:localhost:8384 $USER@10.0.0.3
```

# HDMI 2.1 limitations
References: [1](https://htpc.ninja/how-to-bypass-the-amd-hdmi-2-1-issue-in-bazzite-linux/)

Steam:
- Display setting: 1920×1080 @ 120hz
- Automatically scale image: off
- Automatically scale UI: off
- Max game resolution: 3840×2160 (4k)
- Enable HDR

Game:
- Resolution: 3840×2160 (4k)
- Window mode: full screen
- Quick access menu - Scaling Filter - Sharp: 2
- HDR: on

# Undervolting / Overclocking
References: [1](https://htpc.ninja/htpc-hardware-fine-tuning/), [2](https://www.reddit.com/r/radeon/comments/188k784/undervolt_settings_for_rx_7800_xt_red_devil_16gb/)
## BIOS
- Advanced
  - AMD Overclocking
    - Precision Boost Overdrive
      - Curve optimizer: all cores
      - All core curve optimizer sign: negative
      - All core curve optimizer magnitude: 30
  - PCI Subsystem settings
    - Resize BAR support: enabled

## LACT
### OC
- Power Limit: +15%
- GPU clock offset (MHz): 500
- Maximum VRAM clock (MHz): 2575
- GPU voltage offset (mV): -50

### Thermals
- Curve:
  - 30% at 40c
  - 35% at 50c
  - 40% at 60c
  - 50% at 75c
  - 90% at 85c