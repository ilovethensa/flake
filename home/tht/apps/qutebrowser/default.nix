{
  inputs,
  pkgs,
  ...
}: {
  home.file.".config/qutebrowser/catppuccin".source = inputs.qutebrowser-catppucin;
  programs.qutebrowser = {
    enable = true;
    searchEngines = {
      w = "https://en.wikipedia.org/wiki/Special:Search?search={}&amp;go=Go&amp;ns0=1";
      aw = "https://wiki.archlinux.org/?search={}";
      nw = "https://wiki.nixos.org/index.php?search={}";
      ns = "https://mynixos.com/search?q={}";
      np = "https://search.nixos.org/packages?query={}";
      yt = "https://piped.video/results?search_query={}";
    };
    greasemonkey = [
      (pkgs.fetchurl {
        url = "https://update.greasyfork.org/scripts/466058/Dark%20Reader.user.js";
        sha256 = "sha256-lkZksw4tZcA3jTldcivzh3TDMKqcA38u9sbE3qklQP8=";
      })
    ];
    settings = {
      colors.webpage.preferred_color_scheme = "dark";
    };
    extraConfig = ''
      import catppuccin
      catppuccin.setup(c, 'mocha', True)
    '';
  };
}
