{lib, ...}: {
  networking.firewall = {
    enable = true;
    logRefusedPackets = true;
    logRefusedConnections = true;
  };
  time.timeZone = "Europe/Sofia";
  # Optimizations
  networking.networkmanager.enable = true;
  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
  networking.dhcpcd.extraConfig = ''
    noarp
  '';
}
