{
  pkgs,
  lib,
  config,
  ...
}: let
  service = "meta";
  cfg = config.${service};
in {
  options.${service} = {
    gnome = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.gnome {
    services = {
      xserver = {
        enable = true;
        displayManager.gdm.enable = true;
        desktopManager.gnome.enable = true;
        excludePackages = [pkgs.xterm];
      };
    };
    environment.gnome.excludePackages = with pkgs.gnome; [
      cheese # webcam tool
      gnome-music
      epiphany # web browser
      geary # email reader
      evince # document viewer
      gnome-characters
      totem # video player
      tali # poker game
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game
    ];
  };
}
