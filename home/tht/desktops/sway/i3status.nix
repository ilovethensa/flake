{...}: {
  programs.i3status.enable = true;
  /*
     programs.i3status-rust = {
    enable = true;
    bars = {
      bottom = {
        blocks = [
          {
            block = "net";
            format = "E: $ip ()";
          }
          {
            block = "battery";
            format = " $icon $percentage ";
            missing_format = " $icon ";
          }
          {
            block = "memory";
            format_mem = " $icon $mem_used_percents ";
          }
          {
            block = "disk_space";
            path = "/nix";
            info_type = "available";
            interval = 60;
            warning = 20.0;
            alert = 10.0;
          }

          {
            block = "cpu";
            interval = 1;
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
            theme = "plain";
            overrides = {
              idle_bg = "#123456";
              idle_fg = "#abcdef";
            };
          };
        };
        icons = "awesome5";
        theme = "plain";
      };
    };
  };
  */
}
