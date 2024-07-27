{...}: {
  programs.i3status = {
    enable = true;
    modules = {
      "wireless _first_" = {
        format_down = "W: down";
        format_up = "W: (%quality at %essid) %ip";
      };
      "ethernet _first_" = {
        format_down = "E: down";
        format_up = "E: %ip (%speed)";
      };
      "battery" = {
        format = "%status %percentage %remaining";
      };
      "memory" = {
        format = "%used | %available";
        format_degraded = "MEMORY < %available";
        threshold_degraded = "1G";
      };
      "disk /nix" = {
        format = "%avail";
      };
      "load" = {
        format = "%1min";
      };
      "tztime local" = {
        format = "%Y-%m-%d %H:%M:%S";
      };
    };
  };
}
