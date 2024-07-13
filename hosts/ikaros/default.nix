{
  pkgs,
  lib,
  ...
}: {
  # Import modules and configuration pieces
  imports = [
    ../../profiles/server
    ./hardware-configuration.nix
    ./services/arr.nix
    ./services/caddy.nix
    ./services/jellyseerr.nix
    #./services/cron.nix
    ./services/unmanic.nix
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
  environment.etc = {
    "ssh/sshd_config".text =
      lib.mkForce ''
      '';
  };
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
  #networking.wireguard.enable = true;
  # Persistence configuration
  environment.persistence."/nix/persist" = {
    hideMounts = true;
    directories = [
      "/var/lib"
      "/etc/jellyfin"
      #"/home"
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
