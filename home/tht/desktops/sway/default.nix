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
  # Now symlink the `~/.config/gtk-4.0/` folder declaratively:
  xdg.configFile = {
    "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  };

  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Macchiato-Standard-Blue-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = ["blue"];
        size = "standard";
        variant = "macchiato";
      };
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "macchiato";
        accent = "blue";
      };
    };
    cursorTheme = {
      name = "Catppuccin-Macchiato-Dark-Cursors";
      package = pkgs.catppuccin-cursors.macchiatoDark;
    };
    gtk3 = {
      extraConfig.gtk-application-prefer-dark-theme = true;
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    name = "Catppuccin-Macchiato-Dark-Cursors";
    package = pkgs.catppuccin-cursors.macchiatoDark;
    size = 16;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-theme = "Catppuccin-Macchiato-Standard-Blue-Dark";
      color-scheme = "prefer-dark";
    };

    # For Gnome shell
    "org/gnome/shell/extensions/user-theme" = {
      name = "Catppuccin-Macchiato-Standard-Blue-Dark";
    };
  };
  qt = {
    enable = true;
    platformTheme = "qtct";
    style.name = "kvantum";
  };

  xdg.configFile."Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini {}).generate "kvantum.kvconfig" {
    General.theme = "Catppuccin-Macchiato-Blue";
  };
}
