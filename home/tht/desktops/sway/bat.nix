{pkgs, ...}: {
  programs.bat = {
    enable = true;
    themes = {
      mocha = {
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "bat";
          rev = "82e7ca555f805b53d2b377390e4ab38c20282e83";
          sha256 = "019hfl4zbn4vm4154hh3bwk6hm7bdxbr1hdww83nabxwjn99ndhv";
        };
        file = "themes/Catppuccin Mocha.tmTheme";
      };
    };
  };
}
