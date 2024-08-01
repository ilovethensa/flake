{...}: {
  virtualisation.oci-containers.containers."SovietMC" = {
    image = "itzg/minecraft-server";
    autoStart = true;
    ports = [
      "25565:25565"
      "19132:19132"
      "19132:19132/udp"
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
      PACKWIZ_URL = "https://raw.githubusercontent.com/ilovethensa/better-vanilla/main/pack.toml";
      SEED = "-1476270621647710826";
    };
  };
  services.cloudflare-dyndns.domains = [
    "mc.pwned.page"
  ];
  networking.firewall = {
    allowedTCPPorts = [
      25565
      19132
    ];
    allowedUDPPorts = [
      19132
    ];
  };
}
