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
          font-family: Iosevka;
          font-size: 11pt;
          min-height: 0;
      }
      window#waybar {
          opacity: 0.9;
          background: @background-darker;
          color: @foreground;
          border-bottom: 2px solid @background;
      }
      #workspaces button {
          padding: 0 10px;
          background: @background;
          color: @foreground;
      }
      #workspaces button:hover {
          box-shadow: inherit;
          text-shadow: inherit;
          background-image: linear-gradient(0deg, @selection, @background-darker);
      }
      #workspaces button.active {
          background-image: linear-gradient(0deg, @purple, @selection);
      }
      #workspaces button.urgent {
          background-image: linear-gradient(0deg, @red, @background-darker);
      }
      #taskbar button.active {
          background-image: linear-gradient(0deg, @selection, @background-darker);
      }
      #clock {
          padding: 0 4px;
          background: @background;
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
        margin-top = "7";
        margin-left = "12";
        margin-right = "12";
        margin-bottom = "0";
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
