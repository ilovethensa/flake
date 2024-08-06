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
  environment.persistence."/nix/persist" = {
    hideMounts = true;
    directories = [
      "/home"
      "/var/lib"
      {
        directory = "/root";
        user = "root";
      }
    ];
    files = [
      #"/etc/machine-id"
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/ssh/ssh_host_rsa_key.pub"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
    ];
  };
  # System state version
  system.stateVersion = "23.05";
}
