{pkgs, ...}: {
  # Import modules and configuration pieces
  imports = [
    ./hardware-configuration.nix
    ./vfio.nix
    ./aagl.nix
    ../../profiles/desktop
    ../../nix/configs/users/tht.nix
    ../../nix/configs/gaming.nix
    ../../nix/configs/virtualisation.nix
    ../../nix/services/openssh.nix
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
    rage
    wl-clipboard
  ];
  tht = {
    amd = true;
  };
  virtualisation.waydroid.enable = true;
  environment.persistence."/nix/persist".directories = [
    "/var/lib/libvirt"
  ];
  boot.kernelParams = [
    "amd_iommu=o"
    "iommu=pt"
  ];
  # System state version
  system.stateVersion = "23.05";
}
