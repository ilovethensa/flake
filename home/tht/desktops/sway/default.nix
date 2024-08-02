{
  pkgs,
  inputs,
  config,
  ...
}: {
  imports = [
    ./foot.nix
    ./wm.nix
    ./i3status.nix
    inputs.nix-colors.homeManagerModules.default
  ];
  home.packages = with pkgs; [
    (nerdfonts.override {fonts = ["FiraCode"];})
  ];
  #  colorScheme = {
  #    slug = "some-theme";
  #    name = "some theme";
  #    author = "tht";
  #    palette = {
  #      base00 = "#282c34";
  #      base01 = "#353b45";
  #      base02 = "#3e4451";
  #      base03 = "#545862";
  #      base04 = "#565c64";
  #      base05 = "#abb2bf";
  #      base06 = "#b6bdca";
  #      base07 = "#c8ccd4";
  #      base08 = "#e06c75";
  #      base09 = "#d19a66";
  #      base0A = "#e5c07b";
  #      base0B = "#98c379";
  #      base0C = "#56b6c2";
  #      base0D = "#61afef";
  #      base0E = "#c678dd";
  #      base0F = "#be5046";
  #    };
  #  };
  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;
  qt = {
    enable = true;
    platformTheme = "gtk";
    style.name = "adwaita-dark";
    style.package = pkgs.adwaita-qt;
  };
  dconf.settings = {
    "org/gnome/desktop/background" = {
      picture-uri-dark = "file://${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.src}";
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome.gnome-themes-extra;
    };
  };

  # Wayland, X, etc. support for session vars
  systemd.user.sessionVariables = config.home-manager.users.tht.home.sessionVariables;
}
