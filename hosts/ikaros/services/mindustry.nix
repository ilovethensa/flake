{pkgs, ...}: {
  systemd.services.mindustry = {
    enable = true;
    description = "Mindustry server";
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.mindustry-server}/bin/mindustry-server host";
      ExecStop = "pkill server-release.jar";
      Restart = "on-failure";
    };
    wantedBy = ["default.target"];
  };
  services.cloudflare-dyndns.domains = [
    "n8n.theholytachanka.com"
  ];
  networking.firewall = {
    allowedTCPPorts = [
      6567
    ];
    allowedUDPPorts = [
      6567
    ];
  };
}
