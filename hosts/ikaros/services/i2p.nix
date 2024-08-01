{...}: {
  services.i2pd = {
    enable = true;
    port = 6135;
    dataDir = "/mnt/data/i2pd";
    notransit = false;
    floodfill = true;
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
  ];
  environment.persistence."/nix/persist".directories = [
    "/var/lib/i2pd"
  ];
}
