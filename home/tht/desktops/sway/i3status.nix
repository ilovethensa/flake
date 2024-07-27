{...}: {
  programs.i3status = {
    enable = true;
    modules = {
      "wireless _first_" = {
        settings = {
          format_down = "W: down";
          format_up = "W: (%quality at %essid) %ip";
        };
        position = 1;
      };
      "ethernet _first_" = {
        settings = {
          format_down = "E: down";
          format_up = "E: %ip (%speed)";
        };
        position = 2;
      };
      "battery" = {
        settings = {
          format = "%status %percentage %remaining";
        };
        position = 3;
      };
      "memory" = {
        settings = {
          format = "%used | %available";
          format_degraded = "MEMORY < %available";
          threshold_degraded = "1G";
        };
        position = 4;
      };
      "disk /nix" = {
        settings = {
          format = "%avail";
        };
        position = 5;
      };
      "load" = {
        settings = {
          format = "%1min";
        };
        position = 6;
      };
      "tztime local" = {
        settings = {
          format = "%Y-%m-%d %H:%M:%S";
        };
        position = 7;
      };
    };
  };
}
