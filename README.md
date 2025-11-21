# Quickstart
1. Update Bazzite `ujust update` and reboot
2. Run setup.sh
3. Configure secondary drives in Steam
4. Copy SSH public key to $HOME/.ssh/authorized_keys
5. Copy wireguard key to /etc/wireguard and enable connection: `sudo nmcli con import type wireguard file /etc/wireguard/wg0.conf`
5. Configure Heroic:
   * General -> Set folder for new wine prefix: $HOME/Games/Heroic/Prefixes
   * General -> Automatically update games
   * General -> Add games to Steam automatically
   * Game Defaults -> WinePrefix folder: $HOME/Games/Heroic/Prefixes
   * Add Heroic to Steam (Steam -> Add a Game -> Heroic)
6. In Steam Game Mode:
   * Install Decky Loader plugins
      * SteamGridDB
      * HLTB for Deck
      * Decky Ludusavi
   * (HTPC only) Settings -> Display -> Maximum game resolution -> 3840x2160
7. Reboot

# SteamVR
1. Install SteamVR
2. Set SteamVR launch options: `RADV_PERFTEST=video_encode %command%`
3. Create OpenXR directory: `mkdir -p ~/.config/openxr/1`
4. Set SteamVR as default OpenXR runtime: `ln -s ~/.local/share/Steam/steamapps/common/SteamVR/steamxr_linux64.json ~/.config/openxr/1/active_runtime.json`
5. Disable SteamVR Home

# Emulation
|**Platform**|**Standalone**|**RetroArch Core**|**Default**|
|:---|:---|:---|:---|
|PSX|[DuckStation](https://github.com/stenzek/duckstation)|[Beetle PSX HW](https://docs.libretro.com/library/beetle_psx_hw/)|Standalone|
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

# Port forward syncthing to _this machine
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