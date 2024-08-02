{...}: {
  services = {
    n8n = {
      enable = true;
      webhookUrl = "n8n.theholytachanka.com";
    };
    caddy = {
      enable = true;
      virtualHosts = {
        "n8n.theholytachanka.com".extraConfig = ''
          reverse_proxy http://localhost:5678
        '';
      };
    };
    cloudflare-dyndns.domains = [
      "n8n.theholytachanka.com"
    ];
  };
  security.acme.certs = {
    "n8n.theholytachanka.com" = {};
  };
}
