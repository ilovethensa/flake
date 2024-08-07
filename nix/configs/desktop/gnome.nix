{pkgs, ...}: {
  services = {
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      excludePackages = [pkgs.xterm];
    };
  };
  environment.gnome.excludePackages = with pkgs.gnome;
    [
      gnome-music
      gnome-characters
      tali # poker game
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game
    ]
    ++ [
      pkgs.cheese # webcam tool
      pkgs.epiphany # web browser
      pkgs.geary # email reader
      pkgs.evince # document viewer
      pkgs.totem # video player
    ];
}
