{pkgs, ...}: {
  # Import modules and configuration pieces
  imports = [
    ./hardware-configuration.nix
    ../../profiles/laptop
    ../../nix/configs/users/tht.nix
    ../../nix/configs/gaming.nix
  ];
  home-manager = {
    users = {
      # Import your home-manager configuration
      tht = import ../../home/tht;
    };
  };
  networking.hostName = "mute"; # Define hostname

  environment.systemPackages = with pkgs; [
    aircrack-ng
    wifite2
    hcxtools
    hcxdumptool
    qbittorrent
    tor-browser
    rage
    wl-clipboard
  ];
  tht.intel = true;
  virtualisation.waydroid.enable = true;
  networking.firewall = {
    allowedTCPPorts = [
      3366
    ];
    allowedUDPPorts = [
      3366
    ];
  };
  environment.persistence."/nix/persist".directories = [
    "/var/lib/waydroid"
  ];
  services.blueman.enable = true;
  hardware.bluetooth = {
    enable = true; # enables support for Bluetooth
    powerOnBoot = true; # powers up the default Bluetooth controller on boot
    settings = {
      General = {
        Experimental = true;
      };
    };
  };
  # System state version
  system.stateVersion = "23.05";
}
