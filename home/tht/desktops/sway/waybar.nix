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
          "sway/workspaces"
        ];
        modules-right = [
          "clock"
        ];

        "sway/workspaces" = {
          all-outputs = true;
        };
      };
    };
  };
}
