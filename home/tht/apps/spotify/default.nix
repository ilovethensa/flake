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
    enabledCustomApps = with spicePkgs.apps; [
      marketplace
    ];
  };
}
