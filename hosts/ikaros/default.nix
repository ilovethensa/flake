{pkgs, ...}: {
  # Import modules and configuration pieces
  imports = [
    ../../profiles/server
    ./hardware-configuration.nix
    ./services/arr.nix
    ./services/caddy.nix
    ./services/jellyseerr.nix
    #./services/cron.nix
    #./services/unmanic.nix
    ./services/rimgo.nix
    ./services/libreddit.nix
    #./services/mail.nix
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
  users.users.root = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO1TqzsM18I70A0XhmBjYhryhkRFdGl6ofup92N3XNyC tht" # content of authorized_keys file
      # note: ssh-copy-id will add user@your-machine after the public key
      # but we can remove the "@your-machine" part
    ];
    initialHashedPassword = "$6$dO.lQ2bJZ5PBNhju$WXDIMEWtKFSTw94iRX7Pi2HwsN6hw2q4k3D6UxJXUdMm1VsrtrqpbC/4iyiOBhU.fxWKkugP30s.RuK6IYbWN.";
  };
  #networking.wireguard.enable = true;
  # Persistence configuration
  environment.persistence."/nix/persist" = {
    hideMounts = true;
    directories = [
      "/var/lib"
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
