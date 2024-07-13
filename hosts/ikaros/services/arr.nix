{...}: {
  nixarr = {
    enable = true;
    mediaDir = "/mnt/media";
    stateDir = "/mnt/data";

    jellyfin = {
      enable = true;
      openFirewall = true;
    };
    transmission = {
      enable = false;
      peerPort = 32456;
      #flood.enable = true;
      openFirewall = true;
    };
    bazarr = {
      enable = true;
      openFirewall = true;
    };
    prowlarr = {
      enable = true;
      openFirewall = true;
    };
    radarr = {
      enable = true;
      openFirewall = true;
    };
    sonarr = {
      enable = true;
      openFirewall = true;
    };
  };
  networking.firewall.allowedTCPPorts = [
    3119 # Peer port
  ];
}
