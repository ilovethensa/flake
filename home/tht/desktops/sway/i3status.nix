{...}: {
  programs.i3status-rust = {
    enable = true;
    bars = {
      bottom = {
        icons = "awesome6";
        theme = "ctp-mocha";
        blocks = [
          {
            block = "external_ip";
            format = "BAT $percentage";
          }
          {
            block = "net";
            format = " $icon ^icon_net_down $speed_down.eng(prefix:K) ^icon_net_up $speed_up.eng(prefix:K) ";
          }
          {
            block = "battery";
            format = "BAT $percentage";
          }
          {
            block = "disk_space";
            path = "/";
            info_type = "available";
            interval = 60;
            warning = 20.0;
            alert = 10.0;
          }
          {
            block = "memory";
            format_mem = " $icon $mem_used_percents ";
            format_swap = " $icon $swap_used_percents ";
          }
          {
            block = "cpu";
            interval = 1;
          }
          {
            block = "load";
            interval = 1;
            format = " $icon $1m ";
          }
          {block = "sound";}
          {
            block = "time";
            interval = 60;
            format = " $timestamp.datetime(f:'%a %d/%m %R') ";
          }
        ];
        settings = {
          theme = {
            theme = "solarized-dark";
            overrides = {
              idle_bg = "#123456";
              idle_fg = "#abcdef";
            };
          };
        };
      };
    };
  };
}
