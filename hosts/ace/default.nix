{...}: {
  # Import modules and configuration pieces
  imports = [
    ../../profiles/server
    ./hardware-configuration.nix
    ../../nix/configs/users/tht.nix
    ./services/mail.nix
  ];

  # Networking and system configurationsHE
  networking.hostName = "ace"; # Define hostname

  programs.fish.enable = true;
  # System state version
  meta.persist = false;
  system.stateVersion = "23.05";
}
