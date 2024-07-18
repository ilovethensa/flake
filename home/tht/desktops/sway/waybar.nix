{
  pkgs,
  config,
  ...
}: {
  programs.waybar = {
    enable = true;
    style = ''
      @define-color background-darker #${config.colorScheme.palette.base00};
      @define-color background #${config.colorScheme.palette.base01};
      @define-color selection #${config.colorScheme.palette.base02};
      @define-color foreground #${config.colorScheme.palette.base03};
      @define-color comment #${config.colorScheme.palette.base04};
      @define-color cyan #${config.colorScheme.palette.base05};
      @define-color green #${config.colorScheme.palette.base06};
      @define-color orange #${config.colorScheme.palette.base07};
      @define-color pink #${config.colorScheme.palette.base08};
      @define-color purple #${config.colorScheme.palette.base09};
      @define-color red #${config.colorScheme.palette.base0A};
      @define-color yellow #${config.colorScheme.palette.base0B};
      * {
          border: none;
          border-radius: 0;
          font-family: "FiraCode Nerd Font";
          min-height: 0;
      }

      window#waybar {
          background: @background-darker;
          color: @foreground;
      }

      #workspaces {
          background: @background;
          border: 0.5px solid @selection;
      }

      #workspaces button {
          background: @surface0;
          color: @foreground;
      }

      #workspaces button.visible {
          color: @blue;
      }

      #workspaces button.empty {
          color: @overlay0;
      }

      #workspaces button.active {
          color: @purple;
      }

      #workspaces button.urgent {
          background: @red;
          color: @foreground;
      }

      #taskbar button.active {
          background: @selection;
      }

      #clock {
          padding: 0 8px 0 0;
      }

      #window {
          background: @overlay0;
          padding: 0 0;
          font-weight: bold;
      }

      #battery.critical {
          color: @red;
      }

      #battery.warning {
          color: @orange;
      }
    '';
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        output = [
          "eDP-1"
          "HDMI-A-1"
        ];
        margin-top = 7;
        margin-left = 10;
        margin-right = 10;
        margin-bottom = 0;
        modules-left = [
          "workspaces"
          "cpu"
          "memory"
          "disk"
          "custom/updates"
        ];
        modules-right = [
          "network"
          "battery"
          "pulseaudio"
          "tray"
          "clock"
        ];

        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
        };
        "disk" = {
          interval = 30;
          format = "💾 {percentage_used}%";
          path = "/nix";
        };
        "cpu" = {
          format = "💻 {usage}%";
          tooltip = true;
          on-click = "foot nix-shell - p btop - -command btop";
          interval = 2;
        };
        "memory" = {
          format = "🚃 {}%";
          tooltip = true;
          on-click = "foot nix-shell - p btop - -command btop";
          interval = 2;
        };
        "battery" = {
          states = {
            good = 100;
            warning = 30;
            critical = 10;
          };
          format = "{icon} {capacity}%";
          format-charging = "⚡ {capacity}%";
          format-plugged = "🔌 {capacity}%";
          format-alt = "{icon} {time}";
          # format-good = ""; # An empty format will hide the module
          format-full = "🔋 {capacity}%";
          /*
                       format-icons = [
            "";
            "";
            "";
            "";
            "";
            "";
            "";
            "";
            "";
            "";
          ];
          */
          interval = 2;
        };
        "clock" = {
          timezone = "Europe/Sofia";
          format = "🕓 {:%d <small>%a</small> %H:%M}";
          # format = " {:%a %b %d %Y | %H:%M}";
          format-alt = "🕓 {:%A %B %d %Y (%V) | %r}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          calendar-weeks-pos = "right";
          today-format = "<span color='#f38ba8'><b><u>{}</u></b></span>";
          format-calendar = "<span color='#f2cdcd'><b>{}</b></span>";
          format-calendar-weeks = "<span color='#94e2d5'><b>W{:%U}</b></span>";
          format-calendar-weekdays = "<span color='#f9e2af'><b>{}</b></span>";
          interval = 60;
        };
        "tray" = {
          icon-size = 15;
          spacing = 15;
        };
        "pulseaudio" = {
          # scroll-step = 1; # %, can be a float
          format = "🔊 {volume}%"; # {format_source}
          format-bluetooth = "{icon} {volume}%"; # {format_source}
          format-bluetooth-muted = ""; # {format_source}
          format-muted = "🔇"; # {format_source}
          format-source = "{volume}% ";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            headset = "";
            phone = "";
            portable = "";
            car = " ";
            /*
                           default = [
              "";
              "";
              "";
            ];
            */
          };
          on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
        };
        "network" = {
          # interface = "wlp2*"; # (Optional) To force the use of this interface
          format = "↕{bandwidthTotalBytes}";
          format-disconnected = "{icon} No Internet";
          format-linked = " {ifname} (No IP)";
          format-alt = "↕{bandwidthUpBytes} | ↕{bandwidthDownBytes}";
          tooltip-format = "{ifname}: {ipaddr}/{cidr}  {gwaddr}";
          tooltip-format-wifi = "{icon} {essid} ({signalStrength}%)";
          tooltip-format-ethernet = "{icon} {ipaddr}/{cidr}";
          tooltip-format-disconnected = "{icon} Disconnected";
          on-click-right = "nm-connection-editor";
          format-icons = {
            ethernet = "";
            disconnected = "⚠";
            /*
                           wifi = [
              "睊";
              "直";
            ];
            */
          };
          interval = 2;
        };
        "temperature" = {
          # thermal-zone = 2;
          # hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
          critical-threshold = 40;
          format-critical = "{icon} {temperatureC}°C";
          format = "{icon} {temperatureC}°C";
          /*
                       format-icons = [
            "";
            "";
            "";
          ];
          */
          tooltip = true;
          on-click = "foot nix-shell -p btop --command btop";
          interval = 2;
        };
      };
    };
  };
}
