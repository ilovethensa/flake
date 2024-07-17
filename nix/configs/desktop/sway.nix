{pkgs, ...}: {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
        user = "greeter";
      };
    };
  };
  environment.systemPackages = with pkgs; [
    grim # screenshot functionality
    slurp # screenshot functionality
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    mako # notification system developed by swaywm maintainer
  ];

  # Enable the gnome-keyring secrets vault.
  # Will be exposed through DBus to programs willing to store secrets.
  services.gnome.gnome-keyring.enable = true;

  # enable sway window manager
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  stylix = {
    enable = true;
    image = pkgs.fetchurl {
      url = "https://www.pixelstalk.net/wp-content/uploads/2016/05/Epic-Anime-Awesome-Wallpapers.jpg";
      sha256 = "enQo3wqhgf0FEPHj2coOCvo7DuZv+x5rL/WIo4qPI50=";
    };
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/brogrammer.yaml";
    /*
       base16Scheme = {
      base00 = "282c34"; # ----
      base01 = "353b45"; # ---
      base02 = "3e4451"; # --
      base03 = "545862"; # -
      base04 = "565c64"; # +
      base05 = "abb2bf"; # ++
      base06 = "b6bdca"; # +++
      base07 = "c8ccd4"; # ++++
      base08 = "e06c75"; # red
      base09 = "d19a66"; # orange
      base0A = "e5c07b"; # yellow
      base0B = "98c379"; # green
      base0C = "56b6c2"; # aqua/cyan
      base0D = "61afef"; # blue
      base0E = "c678dd"; # purple
      base0F = "be5046"; # brown
    };
    */
    cursor = {
      package = pkgs.vimix-cursors;
      name = "Vimix-cursors";
    };
    fonts = {
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };

      monospace = {
        package = pkgs.nerdfonts.override {fonts = ["FiraCode"];};
        name = "FiraCode Nerd Font";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}
