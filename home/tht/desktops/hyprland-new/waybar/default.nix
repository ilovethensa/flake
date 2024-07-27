{...}: {
  programs.waybar = {
    enable = true;
    style = ''
      * {
          border: none;
          border-radius: 0px;
          font-family: "JetBrainsMono Nerd Font";
          font-weight: bold;
          font-size: 13px;
          min-height: 10px;
      }

      window#waybar {
          background-color: rgba(0, 0, 0, .0);
      }

      #battery,
      #temperature,
      #clock,
      #workspaces,
      #custom-rofi,
      #tray,
      #pulseaudio,
      #backlight,
      #network,
      #custom-right,
      #custom-left {
         color: @main-color;
         background: #242424;
         margin: 4px 0px 4px 0px;
         opacity: 1;
         border: 0px solid #181825;
      }

      tooltip {
          background: @tool-bg;
          color: @tool-color;
          border-radius: 22px;
          border-width: 2px;
          border-style: solid;
          border-color: #11111b;
      }

      #workspaces button {
          box-shadow: none;
          text-shadow: none;
          padding: 0px;
          border-radius: 9px;
          margin-top: 3px;
          margin-bottom: 3px;
          padding-left: 3px;
          padding-right: 3px;
          color: #ffffff;
          animation: gradient_f 20s ease-in infinite;
          transition: all 0.5s cubic-bezier(.55,-0.68,.48,1.682);
      }

      #workspaces button.active {
          background: #DA025D;
          color: #DDBF98;
          margin-left: 3px;
          padding-left: 12px;
          padding-right: 12px;
          margin-right: 3px;
          animation: gradient_f 20s ease-in infinite;
          transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
      }

      #workspaces button:hover {
          background: #b16286;
          border: none;
      }

      #workspaces {
          padding: 0px;
          padding-left: 5px;
          padding-right: 5px;
      }

      #custom-rofi {
          color: #38ef7d;
          padding-left: 0px;
          padding-right: 10px;
      }

      #temperature {
          color: #eebd35;
          padding-left: 0px;
          padding-right: 19px;
      }

      #temperature.critical {
          color: #ff0000;
          padding-left: 0px;
          padding-right: 19px;
      }

      #backlight {
          color: #FF8B49;
          padding-left: 0px;
          padding-right: 19px;
      }

      #pulseaudio {
          color: #EA879D;
          padding-left: 0px;
          padding-right: 19px;
      }

      #battery {
          color: #458588;
          padding-left: 0px;
          padding-right: 0px;
      }

      #tray {
        padding-left: 0px;
        padding-right: 19px;
      }

      #network {
         padding-left: 0px;
         padding-right: 19px;
      }

      #clock {
         color: #73B580;
         padding-left: 0px;
         padding-right: 0px;
      }

      #custom-right {
          margin-right: 9px;
          padding-right: 3px;
          border-radius: 0px 22px 22px 0px;
      }

      #custom-left {
          margin-left: 9px;
          padding-left: 3px;
          border-radius: 22px 0px 0px 22px;
      }
    '';
    settings = {
      mainBar = {
        position = "top";
        layer = "top";
        height = 15;
        margin-top = 0;
        margin-bottom = 0;
        margin-left = 0;
        margin-right = 0;
        modules-left = ["cpu" "custom/space" "memory" "custom/space" "temperature" "custom/space" "battery"];
        modules-center = ["hyprland/workspaces"];
        modules-right = ["tray" "custom/space" "clock"];

        "custom/space" = {
          format = "┃ {}";
        };

        "cpu" = {
          "format" = "󰻠 {usage}%";
          "format-alt" = "󰻠 {avg_frequency} GHz";
          "interval" = 5;
        };

        "memory" = {
          "format" = "󰍛 {}%";
          "format-alt" = "󰍛 {used}/{total} GiB";
          "interval" = 5;
        };

        "temperature" = {
          "format" = " {temperatureC}°C";
        };

        "battery" = {
          "states" = {
            "good" = 95;
            "warning" = 30;
            "critical" = 20;
          };
          "format" = "{icon} {capacity}%";
          "format-charging" = " {capacity}%";
          "format-plugged" = " {capacity}%";
          "format-alt" = "{time} {icon}";
          "format-icons" = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
        };

        "hyprland/workspaces" = {
          "active-only" = false;
          "all-outputs" = true;
          "disable-scroll" = false;
          "on-scroll-up" = "hyprctl dispatch workspace -1";
          "on-scroll-down" = "hyprctl dispatch workspace +1";
          "format" = "{icon}";
          "on-click" = "activate";
          "format-icons" = {
            "urgent" = "";
            "active" = "";
            "default" = "󰧞";
            "sort-by-number" = true;
          };
        };

        "tray" = {
          "icon-size" = 17;
          "spacing" = 6;
        };

        "clock" = {
          "format" = " {:%I:%M %p   %a %d}";
        };
      };
    };
  };
}
