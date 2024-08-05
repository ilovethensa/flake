{pkgs, ...}: {
  # Import modules and configuration pieces
  imports = [
    ../../profiles/server
    ./hardware-configuration.nix
    ./services/arr.nix
    ./services/caddy.nix
    ./services/jellyseerr.nix
    ./services/unmanic.nix
    ./services/rimgo.nix
    ./services/libreddit.nix
    ./services/minecraft.nix
    ./services/mindustry.nix
    ./services/snowflake.nix
    ./services/i2p.nix
    ./services/n8n.nix
    #./services/isso.nix
    ./services/mail.nix
    ../../nix/configs/users/tht.nix
  ];

  # Networking and system configurationsHE
  networking.hostName = "ikaros"; # Define hostname

  environment.systemPackages = with pkgs; [
    jdk17
    git
    btop
  ];
  meta.intel = true;
  programs.fish.enable = true;
  #networking.wireguard.enable = true;
  # Persistence configuration
  environment.persistence."/nix/persist" = {
    hideMounts = true;
    directories = [
      "/var/lib"
      "/var/tmp" # Fix for pulling containers
      "/etc/jellyfin"
      "/home"
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
