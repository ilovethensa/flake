{...}: {
  virtualisation.oci-containers.containers."readeck" = {
    image = "codeberg.org/readeck/readeck";
    autoStart = true;
    volumes = [
      "/mnt/data/readeck:/readeck"
    ];
    ports = [
      "8000:8000"
    ];
  };
  networking.firewall.allowedTCPPorts = [
    8000
  ];
}
