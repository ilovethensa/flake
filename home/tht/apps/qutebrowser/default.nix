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
      (pkgs.fetchurl {
        url = "https://update.greasyfork.org/scripts/453320/Simple%20Sponsor%20Skipper.user.js";
        sha256 = "sha256-SmdyGmMVEQYV9sQUjwxq8OkJ+7BBqWpkRyNoL5xqiuQ=";
      })
      (pkgs.writeText (builtins.baseNameOf ./redirect.js) (builtins.readFile ./redirect.js))
      #(pkgs.writeText "some-script.js" import ./redirect.nix)
      #(pkgs.fetchurl {
      #  url = "https://update.greasyfork.org/scripts/436359/Privacy%20Redirector.user.js";
      #  sha256 = "sha256-JNdHJxn3WTh6gDWW4YLHSj1UhA4W/jpU5pA6BENB1Jo=";
      #})
      (pkgs.fetchurl {
        url = "https://update.greasyfork.org/scripts/491832/Remove%20Share%20Buttons.user.js";
        sha256 = "sha256-xp+sbM+rcRQ5d3WXm/t+q3fO8GI0Pe0duXC/o3XbwE8=";
      })
    ];
    settings = {
      colors.webpage.preferred_color_scheme = "dark";
      colors.webpage.darkmode.enabled = true;
      auto_save.session = true;
      content.blocking.method = "both";
    };
    extraConfig = ''
      import catppuccin
      catppuccin.setup(c, 'mocha', True)
    '';
  };
}