{pkgs, ...}: {
  imports = [
    ./foot.nix
    ./wm.nix
  ];
  stylix = {
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
