{...}: {
  virtualisation.oci-containers.containers."SovietMC" = {
    image = "itzg/minecraft-server";
    autoStart = true;
    ports = [
      "25565:25565"
    ];
    volumes = [
      "/mnt/data/minecraft/SovietMC:/data"
    ];
    extraOptions = [
      "--tty"
    ];
    environment = {
      EULA = "TRUE";
      TYPE = "FABRIC";
      VERSION = "1.20.4";
      ONLINE_MODE = "FALSE";
      SERVER_NAME = "SovietMC";
      USE_AIKAR_FLAGS = "true";
      MEMORY = "3G";
      PACKWIZ_URL = "https://raw.githubusercontent.com/ilovethensa/VanillaPlus/main/index.toml";
    };
  };
  services.cloudflare-dyndns.domains = [
    "mc.pwned.page"
  ];
  networking.firewall = {
    allowedTCPPorts = [
      25565
    ];
    allowedUDPPorts = [
      19132
    ];
  };
}
