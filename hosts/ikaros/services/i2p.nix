{...}: {
  services.i2pd = {
    enable = true;
    # TCP & UDP
    port = 9898;
    # TCP
    ntcp2.port = 9899;
    inTunnels = {
      theholytachanka = {
        enable = true;
        keys = "theholytachanka.dat";
        inPort = 80;
        address = "localhost";
        destination = "localhost";
        port = 8081;
        inbound.length = 1;
        outbound.length = 1;
      };
    };
    proto = {
      http = {
        enable = true;
        address = "0.0.0.0";
        hostname = "ikaros.local";
      };
      httpProxy = {
        enable = true;
        address = "0.0.0.0";
      };
    };
    enableIPv4 = true;
    enableIPv6 = false;
  };
  networking.firewall = {
    allowedTCPPorts = [
      9898
      9899
      8081

      7070
      4444
    ];
    allowedUDPPorts = [
      9898
      9899
      8081

      7070
      4444
    ];
  };
  environment.persistence."/nix/persist".directories = [
    "/var/lib/i2pd"
  ];
}
