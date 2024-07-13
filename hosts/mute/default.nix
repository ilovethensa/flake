{pkgs, ...}: {
  # Import modules and configuration pieces
  imports = [
    ./hardware-configuration.nix
    ../../profiles/laptop
    ../../nix/configs/users/tht.nix
    ../../nix/configs/desktop/hyprland.nix
  ];
  home-manager = {
    users = {
      # Import your home-manager configuration
      tht = import .../../../../../home/tht;
    };
  };
  networking.hostName = "mute"; # Define hostname

  environment.systemPackages = with pkgs; [
    aircrack-ng
    wifite2
    hcxtools
    hcxdumptool
    qemu
    qbittorrent
    mullvad-browser
    tor-browser
    brave
    rage
    flare-signal
  ];
  networking.firewall = {
    allowedTCPPorts = [
      3366
    ];
    allowedUDPPorts = [
      3366
    ];
  };
  # System state version
  system.stateVersion = "23.05";
}
