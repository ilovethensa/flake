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
    #./services/tor.nix
    #./services/bitmagnet.nix
    ./services/cockpit.nix
<<<<<<< HEAD
    ./services/invidious.nix
=======
    ./services/i2p.nix
    ./services/n8n.nix
>>>>>>> 80976cf2167a3246a40cdd14148d3265182857f7
    ../../nix/configs/users/tht.nix
  ];

  # Networking and system configurations
  networking.hostName = "ikaros"; # Define hostname

  environment.systemPackages = with pkgs; [
    jdk17
    git
    btop
  ];
  services.cockpit = {
    enable = true;
    port = 9090;
    openFirewall = true;
    settings = {
      WebService = {
        AllowUnencrypted = true;
      };
    };
  };
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
