{inputs, ...}: {
  home.file.".config/qutebrowser/catppuccin".source = inputs.qutebrowser-catppucin;
  programs.qutebrowser = {
    enable = true;
    searchEngines = {
      w = "https://en.wikipedia.org/wiki/Special:Search?search={}&amp;go=Go&amp;ns0=1";
      aw = "https://wiki.archlinux.org/?search={}";
      nw = "https://wiki.nixos.org/index.php?search={}";
      ns = "https://mynixos.com/search?q={}";
      np = "https://search.nixos.org/packages?query={}";
    };
    extraConfig = ''
      import catppuccin
      catppuccin.setup(c, 'mocha', True)
    '';
  };
}
