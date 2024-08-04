{ lib, config, pkgs, ... }:

let
  inherit (config.home.sessionVariables) TERMINAL BROWSER;
  modifierBind = "Mod4";
  menu1 = "wofi --show run";
  menu2 = "wofi --show drun";
  editor = "emacsclient -nc";
  leftBind = "h";
  downBind = "j";
  upBind = "k";
  rightBind = "l";
  musicPlayer = "open_ncmpcpp_wezterm";
  screenshot = "grim_satty_screenshot";
in {
  imports = [
    ./mako.nix
    ../polkit/polkit-kde-authentication-agent.nix
    ./sway-waybar.nix
    ./clipboard.nix
  ];

  options = {
    sway.enable = lib.mkEnableOption "enable sway module";
  };

  config = lib.mkIf config.sway.enable {
    home.sessionVariables = {
      MOZ_ENABLE_WAYLAND = 1;
      QT_QPA_PLATFORM = "wayland";
      TERMINAL = "foot";
      _JAVA_AWT_WM_NONREPARENTING = 1;
      NIXOS_OZONE_WL = "1";
    };
    mako.enable = true;
    polkit-kde-authentication-agent.enable = true;
    waybar.enable = true;
    wayland.windowManager.sway = {
      wrapperFeatures.gtk = true;
      checkConfig = false;
      enable = true;
      config = rec {
        modifier = modifierBind;
	      terminal = TERMINAL;
	      menu = menu1;
	      left = leftBind;
	      down = downBind;
	      up = upBind;
	      right = rightBind;
        window.border = 2;
        window.titlebar = false;
        gaps = {
          inner = 5;
        };
        bars = [
          {command = "launch_waybar";}
        ];
        colors.focused = {
          background = "#285577";
          border = "#b5e8e0";
          childBorder = "#285577";
          indicator = "#2e9ef4";
          text = "#ffffff";
        };
        colors.unfocused = {
          background = "#1E1E2E";
          border = "#333333";
          childBorder = "#1E1E2E";
          indicator = "#292d2e";
          text = "#888888";
        };
# 	      bars = [
# 	  {
# 	    fonts = {
# 	      names = [ "DejaVu Sans Mono" "FontAwesome5Free" ];
# 	      style = "Book";
# 	      size = 11.0;
# 	    };
# 	    statusCommand = "i3status";
# 	    position = "top";
# 	    mode = "dock";
# 	    hiddenState = "hide";
# 	    workspaceButtons = true;
# 	    # trayOutput = "primary";
# 	    extraConfig = ''
# 	      separator_symbol " • "
# 	    '';
# 	    colors = {
#               background = "#000000";
#               statusline = "#ffffff";
#               separator = "#666666";
# 	      focusedWorkspace = {
# 	        background = "#4c7899";
# 		border = "#285577";
# 		text = "#ffffff";
# 	      };
# 	      activeWorkspace = {
# 	        background = "#333333";
# 		border = "#5f676a";
# 		text = "#ffffff";
# 	      };
# 	      inactiveWorkspace = {
# 	        background = "#333333";
# 		border = "#222222";
# 		text = "#888888";
# 	      };
# 	      urgentWorkspace = {
# 	        background = "#2f343a";
# 		border = "#900000";
# 		text = "#ffffff";
# 	      };
# 	      bindingMode = {
# 	        background = "#2f343a";
# 		border = "#900000";
# 		text = "#ffffff";
# 	      };
#             };
# 	  }
# 	];
	workspaceOutputAssign = [
	  {
	    workspace = "1";
	    output = "DP-3";
	  }
	  {
	    workspace = "2";
	    output = "DP-3";
	  }
	  {
	    workspace = "3";
	    output = "DP-3";
	  }
	  {
	    workspace = "4";
	    output = "HDMI-A-1";
	  }
	  {
	    workspace = "4";
	    output = "HDMI-A-1";
	  }
	  {
	    workspace = "6";
	    output = "HDMI-A-1";
	  }
	  {
	    workspace = "7";
	    output = "DP-3";
	  }
	  {
	    workspace = "8";
	    output = "DP-3";
	  }
	  {
	    workspace = "9";
	    output = "DP-3";
	  }
	  {
	    workspace = "10";
	    output = "DP-3";
	  }
	];
	window.commands = [
	  {
	    command = "floating enable";
	    criteria = {
	      window_role = "dialog";
	    };
	  }
    {
      command = "floating enable";
      criteria = {
        app_id = "org.gnome.clocks";
      };
    }
	  {
	    command = "floating enable";
	    criteria = {
	      app_id = "mpv";
	    };
	  }
	  {
	    command = "inhibit_idle fullscreen";
	    criteria = {
	      class = ".*";
	    };
	  }
	  {
	    command = "inhibit_idle fullscreen";
	    criteria = {
	      app_id = ".*";
	    };
	  }
	  {
	    command = "floating enable";
	    criteria = {
	      workspace = "7";
	    };
	  }
	  {
	    command = "floating enable";
	    criteria = {
	      app_id = "org.wezfurlong.wezterm";
	    };
	  }
	  {
	    command = "floating enable";
	    criteria = {
	      app_id = "org.kde.kalarm";
	    };
	  }
	  {
	    command = "floating enable";
	    criteria = {
	      app_id = "org.kde.kronometer";
	    };
	  }
	  {
	    command = "floating enable";
	    criteria = {
	      app_id = "org.keepassxc.KeePassXC";
	    };
	  }
	];
	
	keybindings = lib.mkOptionDefault {
	  "${modifierBind}+Shift+d" = "exec ${menu2}";
	  "${modifierBind}+Shift+b" = "exec ${BROWSER}";
	  "${modifierBind}+Shift+m" = "exec ${musicPlayer}";
	  "${modifierBind}+o" = "exec waybar_toggle";

    XF86AudioRaiseVolume = "exec pactl set-sink-volume @DEFAULT_SINK@ +5% && pactl get-sink-volume @DEFAULT_SINK@ | head -n 1| awk '{print substr($5, 1, length($5)-1)}' > /tmp/wobpipe";
    XF86AudioLowerVolume = "exec pactl set-sink-volume @DEFAULT_SINK@ -5% && pactl get-sink-volume @DEFAULT_SINK@ | head -n 1 | awk '{print substr($5, 1, length($5)-1)}' > /tmp/wobpipe";
    XF86AudioMute = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
    XF86AudioMicMute = "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle";
    XF86MonBrightnessDown = "exec brightnessctl set 5%-";
    XF86MonBrightnessUp = "exec brightnessctl set 5%+";
    XF86AudioPlay = "exec playerctl play-pause";
    XF86AudioNext = "exec playerctl next";
    XF86AudioPrev = "exec playerctl previous";
    Print = "exec ${screenshot}";

    "${modifierBind}+1" = "workspace number 1; exec 'echo 1 > /tmp/sovpipe'";
    "${modifierBind}+2" = "workspace number 2; exec 'echo 1 > /tmp/sovpipe'";
    "${modifierBind}+3" = "workspace number 3; exec 'echo 1 > /tmp/sovpipe'";
    "${modifierBind}+4" = "workspace number 4; exec 'echo 1 > /tmp/sovpipe'";
    "${modifierBind}+5" = "workspace number 5; exec 'echo 1 > /tmp/sovpipe'";
    "${modifierBind}+6" = "workspace number 6; exec 'echo 1 > /tmp/sovpipe'";
    "${modifierBind}+7" = "workspace number 7; exec 'echo 1 > /tmp/sovpipe'";
    "${modifierBind}+8" = "workspace number 8; exec 'echo 1 > /tmp/sovpipe'";
    "${modifierBind}+9" = "workspace number 9; exec 'echo 1 > /tmp/sovpipe'";
    "${modifierBind}+0" = "workspace number 10; exec 'echo 1 > /tmp/sovpipe'";

    "--release ${modifierBind}+1" = "exec 'echo 0 > /tmp/sovpipe'";
    "--release ${modifierBind}+2" = "exec 'echo 0 > /tmp/sovpipe'";
    "--release ${modifierBind}+3" = "exec 'echo 0 > /tmp/sovpipe'";
    "--release ${modifierBind}+4" = "exec 'echo 0 > /tmp/sovpipe'";
    "--release ${modifierBind}+5" = "exec 'echo 0 > /tmp/sovpipe'";
    "--release ${modifierBind}+6" = "exec 'echo 0 > /tmp/sovpipe'";
    "--release ${modifierBind}+7" = "exec 'echo 0 > /tmp/sovpipe'";
    "--release ${modifierBind}+8" = "exec 'echo 0 > /tmp/sovpipe'";
    "--release ${modifierBind}+9" = "exec 'echo 0 > /tmp/sovpipe'";
    "--release ${modifierBind}+0" = "exec 'echo 0 > /tmp/sovpipe'";

    "${modifierBind}+Return" = "echo";
    "${modifierBind}+Shift+Return" = "exec ${TERMINAL}";
    "${modifierBind}+Shift+q" = "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";
    "${modifierBind}+q" = "kill";
    "${modifierBind}+Shift+e" = "exec ${editor}";
	};

	modes = {
	  resize = {
            Down = "resize grow height 10 px";
            Escape = "mode default";
            Left = "resize shrink width 10 px";
            Return = "mode default";
            Right = "resize grow width 10 px";
            Up = "resize shrink height 10 px";
            "${left}" = "resize shrink width 10 px";
            "${down}" = "resize grow height 10 px";
            "${up}" = "resize shrink height 10 px";
            "${right}" = "resize grow width 10 px";
	  };
	};

	output = {
	  DP-3 = {
	    bg = "/etc/nixos/shared/Images/default.jpg fill";
	    mode = "3440x1440@144Hz";
	    position = "0,0";
	  };
	  HDMI-A-1 = {
	    bg = "/etc/nixos/shared/Images/default.jpg fill";
	    mode = "1920x1200@75Hz";
	    position = "3440,0";
	    transform = "90";
	  };
	};
	startup = [
	  {command = "rm -f /tmp/wobpipe && mkfifo /tmp/wobpipe && tail -f /tmp/wobpipe | wob";}
	  {command = "rm -f /tmp/sovpipe && mkfifo /tmp/sovpipe && tail -f /tmp/sovpipe | sov -t 500";}
	  {command = "wlsunset -T 8000 -g 0.8";}
	  {command = "fcitx5";}
	  {command = ''
	    exec swayidle -w \
	      timeout 1800 'swaylock -f' \
	      timeout 1805 'swaymsg "output * power off"' \
	      resume 'swaymsg "output * power on"' \
              before-sleep 'playerctl pause' \
              before-sleep 'swaylock'
	  '';}
	  {command = "wallpaper_random";}
	  {command = "start-cliphist";}
	];
      };
      extraConfig = ''
        # Input
        input "type:keyboard" {
          xkb_options caps:escape
          repeat_rate 60
          repeat_delay 500
        }
        # No titlebar
        default_border none
        default_floating_border none
        font monospace 0.001
        titlebar_padding 1
        titlebar_border_thickness 0
      '';
    };
  };
}
