{pkgs, ...}: {
  # Import modules and configuration pieces
  imports = [
    ./hardware-configuration.nix
    ../../profiles/laptop
    ../../nix/configs/users/tht
  ];

  meta = {
    hyprland = true;
    intel = true;
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
