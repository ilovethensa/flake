{pkgs, ...}: {
  # Import modules and configuration pieces
  imports = [
    ./hardware-configuration.nix
    ../../profiles/desktop
    ../../nix/configs/users/tht.nix
    ../../nix/configs/desktop/sway.nix
    ../../nix/configs/gaming.nix
    ../../nix/options
  ];
  home-manager = {
    users = {
      # Import your home-manager configuration
      tht = import ../../home/tht;
    };
  };
  networking.hostName = "viper"; # Define hostname

  environment.systemPackages = with pkgs; [
    qbittorrent
    tor-browser
    brave
    rage
    flare-signal
    wl-clipboard
  ];
  meta = {
    amd = true;
  };
  virtualisation.waydroid.enable = true;
  environment.persistence."/nix/persist".directories = [
    "/var/lib/waydroid"
  ];
  # System state version
  system.stateVersion = "23.05";
}
