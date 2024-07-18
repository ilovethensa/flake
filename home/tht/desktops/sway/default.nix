{
  pkgs,
  inputs,
  nix-colors,
  ...
}: {
  imports = [
    ./foot.nix
    ./wm.nix
    ./waybar.nix
    inputs.nix-colors.homeManagerModules.default
  ];
  home.packages = with pkgs; [
    (nerdfonts.override {fonts = ["FiraCode"];})
  ];
  colorScheme = nix-colors.colorSchemes.dracula;
  qt = {
    enable = true;
    platformTheme = "gtk";
    style.name = "adwaita-dark";
    style.package = pkgs.adwaita-qt;
  };
  gtk = {
    enable = true;
    cursorTheme.package = pkgs.bibata-cursors;
    cursorTheme.name = "Bibata-Modern-Ice";
    theme.package = pkgs.adw-gtk3;
    theme.name = "adw-gtk3";
  };
}
