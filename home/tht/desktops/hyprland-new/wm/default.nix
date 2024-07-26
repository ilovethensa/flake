{pkgs, ...}: {
  home.packages = with pkgs; [
    rofi-wayland
    gammastep
  ];
  # Configure Wayland window manager
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    # Enable systemd service
    systemd = {
      enable = true;
    };

    # Window manager settings
    settings = {
      # ░█▀▀█ █── ░█─░█ ░█▀▀█
      # ░█▀▀▄ █── ░█─░█ ░█▄▄▀
      # ░█▄▄█ ▀▀▀ ─▀▄▄▀ ░█─░█

      decoration = {
        rounding = 10;
        drop_shadow = false;

        blur = {
          enabled = true;
          size = 6;
          passes = 3;
          new_optimizations = true;
          ignore_opacity = true;
          xray = false;
        };
      };

      # ▀█▀ ▒█▄░▒█ ▒█▀▀█ █░░█ ▀▀█▀▀
      # ▒█░ ▒█▒█▒█ ▒█▄▄█ █░░█ ░░█░░
      # ▄█▄ ▒█░░▀█ ▒█░░░ ░▀▀▀ ░░▀░░

      input = {
        kb_layout = "us,bg";
        kb_variant = ",phonetic";
        kb_options = grp:alt_space_toggle;
        follow_mouse = 1;

        touchpad = {
          natural_scroll = true;
        };

        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
        force_no_accel = 1;
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
      };
      # ░█▀▀█ █▀▀▄ ▀█▀ █▀▄▀█ █▀▀█ ▀▀█▀▀ ▀█▀ █▀▀█ █▀▀▄
      # ▒█▄▄█ █░░█ ▒█░ █░▀░█ █▄▄█ ░░█░░ ▒█░ █░░█ █░░█
      # ▒█░▒█ ▀░░▀ ▄█▄ ▀░░░▀ ▀░░▀ ░░▀░░ ▄█▄ ▀▀▀▀ ▀░░▀

      animations = {
        enabled = true;
      };

      "$mod" = "ALT";
      # Key bindings
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        #"$mod ALT, mouse:272, resizewindow"
      ];

      bind =
        [
          "$mod, F, fullscreen"
          "$mod, S, exec, ${pkgs.grimblast}/bin/grimblast copy area"
          "$mod, D, exec, pkill rofi || rofi -show drun"
          "$mod, Return, exec, foot"
          "$mod, Q, killactive,"
          "$mod, W, togglefloating," # toggle the window on focus to float
        ]
        ++ (
          # Workspace bindings
          builtins.concatLists (builtins.genList
            (
              x: let
                ws = let
                  c = (x + 1) / 10;
                in
                  builtins.toString (x + 1 - (c * 10));
              in [
                "$mod, ${ws}, workspace, ${toString (x + 1)}"
                "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
            )
            10)
        );
    };

    # Additional configurations
    extraConfig = ''
      # ▒█░░░ █▀▀█ ▒█░▒█ ▒█▄░▒█ █▀▀ █░░█
      # ▒█░░░ █▄▄█ ▒█░▒█ ▒█▒█▒█ █░░ █▀▀█
      # ▒█▄▄█ ▀░░▀ ░▀▄▄▀ ▒█░░▀█ ▀▀▀ ▀░░▀

      exec = "${pkgs.psmisc}/bin/killall -SIGUSR2 .waybar-wrapped"; # Restart waybar
      exec-once = /usr/lib/polkit-kde-authentication-agent-1 # authentication dialogue for GUI apps
      exec-once = ${pkgs.waybar}/bin/waybar # launch the system panel
      exec-once = gammastep-indicator - t 6500:2500 -l 42.13058:24.73996


      # ░█▀▀█ █── ░█─░█ ░█▀▀█
      # ░█▀▀▄ █── ░█─░█ ░█▄▄▀
      # ░█▄▄█ ▀▀▀ ─▀▄▄▀ ░█─░█

      #layerrule = "blur,waybar";
      #layerrule = "blur,rofi";
      #layerrule = "blur,^(eww-blur)$";


      # ▒█▀▀▀ ▒█▄░▒█ ▒█░░▒█
      # ▒█▀▀▀ ▒█▒█▒█ ░▒█▒█░
      # ▒█▄▄▄ ▒█░░▀█ ░░▀▄▀░

      env = XDG_CURRENT_DESKTOP,Hyprland
      env = XDG_SESSION_TYPE,wayland
      env = XDG_SESSION_DESKTOP,Hyprland
      env = GDK_BACKEND,wayland
      env = QT_QPA_PLATFORM,wayland
      env = QT_QPA_PLATFORMTHEME,qt5ct
      env = QT_WAYLAND_DISABLE_WINDOWDECORATION,1
      env = QT_AUTO_SCREEN_SCALE_FACTOR,1
      env = MOZ_ENABLE_WAYLAND,1


      # ▒█▀▀▀█ ▒█▀▀█ ░█▀▀█ ▒█▀▀█ ▀█▀ ▀▀█▀▀ ▒█░░▒█
      # ▒█░░▒█ ▒█▄▄█ ▒█▄▄█ ▒█░░░ ▒█░ ░▒█░░ ▒█▄▄▄█
      # ▒█▄▄▄█ ▒█░░░ ▒█░▒█ ▒█▄▄█ ▄█▄ ░▒█░░ ░░▒█░░


      windowrulev2 = opacity 0.60 0.60,class:^(Brave Browser)$
      windowrulev2 = opacity 0.66 0.66,class:^(Spotify)$
      windowrulev2 = opacity 0.60 0.60,class:^(foot)$
      windowrulev2 = opacity 0.60 0.60,class:^(Code)$
      windowrulev2 = opacity 0.60 0.60,class:^(code-url-handler)$

      windowrulev2 = float,class:^(Signal)$ #Signal-Gtk
      windowrulev2 = float,class:^(net.davidotek.pupgui2)$ #ProtonUp-Qt
      windowrulev2 = float,class:^(pavucontrol)$
    '';
  };
}
