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
          padding: 0;
          margin-top: 0.5em;
          margin-bottom: 0.5em;
      }

      #workspaces button {
          background: @surface0;
          color: @foreground;
          font-size: 1.25em;
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

      #pulseaudio-slider trough, #backlight-slider trough {
          min-height: 10px;
          min-width: 80px;
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
        modules-left = ["sway/workspaces"];
        modules-center = ["sway/window" "custom/hello-from-waybar"];
        modules-right = ["mpd" "custom/mymodule#with-css-id" "temperature"];

        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
        };
        "custom/hello-from-waybar" = {
          format = "hello {}";
          max-length = 40;
          interval = "once";
          exec = pkgs.writeShellScript "hello-from-waybar" ''
            echo "from within waybar"
          '';
        };
      };
    };
  };
}
