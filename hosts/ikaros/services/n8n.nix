{_}: {
  virtualisation.oci-containers.containers."n8n" = {
    image = "docker://docker.n8n.io/n8nio/n8n:latest";
    ports = ["5678:5678"];
    volumes = ["/mnt/data/n8n:/home/node/.n8n"];
    environment = {WEBHOOK_URL = "https://n8n.theholytachanka.com";};
    autoStart = true;
  };
  services.caddy = {
    enable = true;
    virtualHosts = {
      "n8n.theholytachanka.com".extraConfig = ''
        reverse_proxy http://localhost:5678
      '';
    };
  };
  services.cloudflare-dyndns = {
    domains = [
      "n8n.theholytachanka.com"
    ];
  };
  security.acme = {
    certs = {
      "n8n.theholytachanka.com" = {};
    };
  };
  networking.firewall.allowedTCPPorts = [
    5678
  ];
}
