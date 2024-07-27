{pkgs, ...}: {
  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod1";
      # Use kitty as default terminal
      terminal = "${pkgs.foot}/bin/footclient";
      keybindings = {
        "control+shift+escape" = "exec $term ${pkgs.btop}/bin/btop";
        "Print" = "exec --no-startup-id ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp -d)\" - | ${pkgs.wl-clipboard-rs}/bin/wl-copy && ${pkgs.libnotify}/bin/notify-send \"Screenshot taken\" -i camera-photo-symbolic";

        "${modifier}+Return" = "exec ${pkgs.foot}/bin/foot";
        "${modifier}+d" = "exec ${pkgs.rofi}/bin/rofi -show drun -show-icons | ${pkgs.findutils}/bin/xargs swaymsg exec --";
        "${modifier}+q" = "kill";
        "${modifier}+f" = "fullscreen toggle";
        "${modifier}+1" = "workspace 1";
        "${modifier}+2" = "workspace 2";
        "${modifier}+3" = "workspace 3";
        "${modifier}+4" = "workspace 4";
        "${modifier}+5" = "workspace 5";
        "${modifier}+6" = "workspace 6";
        "${modifier}+7" = "workspace 7";
        "${modifier}+8" = "workspace 8";
        "${modifier}+9" = "workspace 9";
        "${modifier}+0" = "workspace 10";
        "${modifier}+Shift+1" = "move container to workspace 1";
        "${modifier}+Shift+2" = "move container to workspace 2";
        "${modifier}+Shift+3" = "move container to workspace 3";
        "${modifier}+Shift+4" = "move container to workspace 4";
        "${modifier}+Shift+5" = "move container to workspace 5";
        "${modifier}+Shift+6" = "move container to workspace 6";
        "${modifier}+Shift+7" = "move container to workspace 7";
        "${modifier}+Shift+8" = "move container to workspace 8";
        "${modifier}+Shift+9" = "move container to workspace 9";
        "${modifier}+Shift+0" = "move container to workspace 10";
        "${modifier}+Left" = "focus left";
        "${modifier}+Down" = "focus down";
        "${modifier}+Up" = "focus up";
        "${modifier}+Right" = "focus right";
        "${modifier}+Shift+Left" = "move left";
        "${modifier}+Shift+Down" = "move down";
        "${modifier}+Shift+Up" = "move up";
        "${modifier}+Shift+Right" = "move right";
        # Brightness
        "XF86MonBrightnessDown" = "exec ${pkgs.light}/bin/light -U 10";
        "XF86MonBrightnessUp" = "exec ${pkgs.light}/bin/light -A 10";
        # Audio
        "XF86AudioRaiseVolume" = "exec '${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +1%'";
        "XF86AudioLowerVolume" = "exec '${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -1%'";
        "XF86AudioMute" = "exec '${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle'";
      };
      startup = [
        {command = "${pkgs.gammastep}/bin/gammastep -o -O 2000";}
        {command = "${pkgs.foot}/bin/foot -s";}
      ];
      floating.criteria = [
        {
          class = "^Steam$";
          title = "^Friends$";
        }
        {
          class = "^Steam$";
          title = "Steam - News";
        }
        {
          class = "^Steam$";
          title = ".* - Chat";
        }
        {
          class = "^Steam$";
          title = "^Settings$";
        }
        {
          class = "^Steam$";
          title = ".* - event started";
        }
        {
          class = "^Steam$";
          title = ".* CD key";
        }
        {
          class = "^Steam$";
          title = "^Steam - Self Updater$";
        }
        {
          class = "^Steam$";
          title = "^Screenshot Uploader$";
        }
        {
          class = "^Steam$";
          title = "^Steam Guard - Computer Authorization Required$";
        }
        {title = "^Steam Keyboard$";}
        {title = "Discord Updater";}
      ];
      bars = [
        {
          statusCommand = "${pkgs.i3status}/bin/i3status";
        }
      ];
    };
    extraConfig = ''
      gaps inner 10
      # Disable window titlebars
      default_border pixel 2
      #output * background /home/tht/Pictures/wall.png fill
      input type:touchpad {
        tap enabled
        natural_scroll enabled
      }
      bindgesture swipe:right workspace prev
      bindgesture swipe:left workspace next
      for_window [shell="xwayland"] title_format "[XWayland] %title"
      for_window [title="Picture-in-picture"] floating enable, sticky toggle # Fix Chrome PIP
      for_window [app_id="firefox" title="Picture-in-Picture"] floating enable, sticky enable, border none
    '';
  };
}
