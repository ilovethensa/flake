{lib, ...}: {
  networking = {
    networkmanager.enable = true;
    dhcpcd.extraConfig = ''
      noarp
    '';
    firewall = {
      enable = true;
      logRefusedPackets = true;
      logRefusedConnections = true;
    };
  };
  time.timeZone = "Europe/Sofia";
  # Optimizations
  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
}
