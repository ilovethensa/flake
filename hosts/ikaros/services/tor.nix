{...}: {
  services.tor = {
    enable = true;

    # Disable GeoIP to prevent the Tor client from estimating the locations of Tor nodes it connects to
    enableGeoIP = false;

    # Enable and configure the Tor relay
    relay = {
      enable = true;
      role = "relay"; # Set the relay role (e.g., "relay", "bridge")
    };
    openFirewall = true;
    # Configure Tor settings
    settings = {
      Nickname = "tht";
      ContactInfo = "me@theholytachanka.com";

      # Bandwidth settings
      MaxAdvertisedBandwidth = "5 MB";
      BandWidthRate = "3 MB";
      RelayBandwidthRate = "3 MB";
      RelayBandwidthBurst = "5 MB";

      # Reject all exit traffic
      ExitPolicy = "reject *:*";

      # Performance and security settings
      CookieAuthentication = true;
      AvoidDiskWrites = 1;
      HardwareAccel = 1;
      SafeLogging = 1;
      NumCPUs = 2;

      Address = "91.139.255.24";
      AuthDirHasIPv6Connectivity = false;
      IPv4Only = true;

      # Network settings
      ORPort = [456];
    };
  };
}
