{pkgs, ...}: {
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
    keymap = {
      input.keymap = [
        {
          exec = "close";
          on = ["<c-q>"];
        }
        {
          exec = "close --submit";
          on = ["<enter>"];
        }
        {
          exec = "escape";
          on = ["<esc>"];
        }
        {
          exec = "backspace";
          on = ["<backspace>"];
        }
      ];
      manager.keymap = [
        {
          exec = "shell \"$SHELL\" --block --confirm";
          on = ["<C-s>"];
        }
        {
          exec = "escape";
          on = ["<esc>"];
        }
        {
          exec = "quit";
          on = ["q"];
        }
        {
          exec = "close";
          on = ["<c-q>"];
        }
      ];
    };
  };
}
