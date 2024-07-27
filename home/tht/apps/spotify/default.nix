{
  pkgs,
  lib,
  spicetify-nix,
  ...
}: let
  spicePkgs = spicetify-nix.packages.${pkgs.system}.default;
in {
  imports = [spicetify-nix.homeManagerModule];
  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      fullAppDisplay
      adblock
    ];
          enabledCustomApps = with spicePkgs.apps; [
        marketplace
      ];
  };
}
