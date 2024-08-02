{pkgs, ...}: {
  home.file.".config/yazi/theme.toml".source = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/yazi/main/themes/mocha.toml";
    sha256 = "0bhccaf3m3mhhqwfxhwds1rhb228pxj014mrd5hm7ys52jkqljxb";
  };
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      log = {
        enabled = false;
      };
      manager = {
        show_hidden = true;
        sort_by = "modified";
        sort_dir_first = true;
        sort_reverse = true;
      };
      openers = {
        edit = [
          {
            run = "nvim \"$@\"";
            block = true;
          }
        ];
        play = [
          {
            run = "${pkgs.vlc}/bin/vlc \"$@\"";
            orphan = true;
            for = "unix";
          }
        ];
        open = [
          {
            run = "${pkgs.xdg-utils}/bin/xdg-open \"$@\"";
            desc = "Open";
          }
        ];
      };
    };
  };
}
