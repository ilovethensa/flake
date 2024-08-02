{...}: {
  services.i2pd = {
    enable = true;
    port = 6135;
    dataDir = "/mnt/data/i2pd";
    notransit = false;
    floodfill = true;
    ntcp2.port = 9899;
    inTunnels = {
      tht = {
        inbound.length = 1;
        outbound.length = 1;
        enable = true;
        keys = "tht.dat";
        inPort = 80;
        address = "::1";
        destination = "localhost";
        port = 3568;
        # inbound.length = 1;
        # outbound.length = 1;
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
  };
  networking.firewall.allowedTCPPorts = [
    6135
    7070
    4444
    3568
    9899
  ];
  environment.persistence."/nix/persist".directories = [
    "/var/lib/i2pd"
  ];
}
