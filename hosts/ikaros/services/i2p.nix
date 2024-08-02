{config, ...}: {
  services.nginx = {
    enable = true;
    defaultSSLListenPort = 56783;
    defaultHTTPListenPort = 5642;
    virtualHosts."localhost" = {
      root = "/var/www/theholytachanka.com";
    };
  };
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
        address = "127.0.0.1";
        destination = "localhost";
        port = config.services.nginx.defaultHTTPListenPort;
        inbound.length = 1;
        outbound.length = 1;
      };
    };
    proto = {
      http = {
        enable = true;
        address = "192.168.1.111";
        hostname = "ikaros.local";
      };
      httpProxy = {
        enable = true;
        address = "192.168.1.111";
      };
    };
    enableIPv4 = true;
    enableIPv6 = false;
  };
  networking.firewall = {
    allowedTCPPorts = [
      9898
      9899
      1346

      7070
      4444
    ];
    allowedUDPPorts = [
      9898
      9899
      1346

      7070
      4444
    ];
  };
  environment.persistence."/nix/persist".directories = [
    "/var/lib/i2pd"
  ];
}
