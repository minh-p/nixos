{ config, lib, pkgs, ... }:
let
  inherit (config.home.sessionVariables) WALLPAPERS_SRC;

  open_nmtui_wezterm = pkgs.writeShellScriptBin "open_nmtui_wezterm" ''
    wezterm-gui -e nmtui &
  '';

  grim_satty_screenshot = pkgs.writeShellScriptBin "grim_satty_screenshot" ''
    grim -g "$(slurp -c '#ff0000ff')" - | satty --filename - --output-filename ~/Pictures/Screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png
  '';

  open_ncmpcpp_wezterm = pkgs.writeShellScriptBin "open_ncmpcpp_wezterm" ''
    #!/bin/sh
    if pgrep -x "ncmpcpp" > /dev/null
    then
      pkill -9 ncmpcpp
    else
      wezterm-gui -e ncmpcpp
    fi
  '';

  wofi_powermenu = pkgs.writeShellScriptBin "wofi_powermenu" ''
    op=$( echo -e " Poweroff\n Reboot\n Suspend\n Lock\n Logout\n Hibernate" | wofi -i --dmenu | awk '{print tolower($2)}' )

    case $op in
        poweroff)
          ;&
        reboot)
          ;&
        suspend)
          ;&
        hibernate)
          systemctl $op
          ;;
        lock)
          swaylock
          ;;
        logout)
          swaymsg exit
          ;;
    esac
  '';
  default_wallpaper = pkgs.writeShellScriptBin "default_wallpaper" ''
    if command -v swaybg >/dev/null 2>&1; then
       killall swaybg
       killall dynamic_wallpaper
       swaybg -i $(find /etc/nixos/shared/Images/. -name "default.jpg" | shuf -n1) -m fill &
    fi
  '';
  wallpaper_random = pkgs.writeShellScriptBin "wallpaper_random" ''
    if command -v swww >/dev/null 2>&1; then
        killall dynamic_wallpaper
        swww img $(find ${WALLPAPERS_SRC} -name "*.*g" | shuf -n1) --transition-type random
    else
        killall swaybg
        killall dynamic_wallpaper
        swaybg -i $(find ${WALLPAPERS_SRC} -name "*.*g" | shuf -n1) -m fill &
    fi
  '';
  dynamic_wallpaper = pkgs.writeShellScriptBin "dynamic_wallpaper" ''
    if command -v swww >/dev/null 2>&1; then
        swww img $(find ${WALLPAPERS_SRC} -name "*.*g" | shuf -n1) --transition-type random
        OLD_PID=$!
        while true; do
            sleep 120
        swww img $(find ${WALLPAPERS_SRC} -name "*.*g" | shuf -n1) --transition-type random
            NEXT_PID=$!
            sleep 5
            kill $OLD_PID
            OLD_PID=$NEXT_PID
        done
    elif command -v swaybg >/dev/null 2>&1; then
        killall swaybg
        swaybg -i $(find ${WALLPAPERS_SRC} -name "*.*g" | shuf -n1) -m fill &
        OLD_PID=$!
        while true; do
            sleep 120
            swaybg -i $(find ${WALLPAPERS_SRC} -name "*.*g" | shuf -n1) -m fill &
            NEXT_PID=$!
            sleep 5
            kill $OLD_PID
            OLD_PID=$NEXT_PID
        done
    else
        killall feh
        feh --randomize --bg-fill $(find ${WALLPAPERS_SRC} -name "*.*g" | shuf -n1) &
        OLD_PID=$!
        while true; do
            sleep 120
            feh --randomize --bg-fill $(find ${WALLPAPERS_SRC} -name "*.*g" | shuf -n1) &
            NEXT_PID=$!
            sleep 5
            kill $OLD_PID
            OLD_PID=$NEXT_PID
        done
    fi
  '';
in {
  home.packages = with pkgs; [
    dynamic_wallpaper
    wallpaper_random
    default_wallpaper
    wofi_powermenu
    grim_satty_screenshot
    open_ncmpcpp_wezterm
    open_nmtui_wezterm
  ];
}
