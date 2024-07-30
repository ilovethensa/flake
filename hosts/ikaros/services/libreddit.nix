{...}: {
  services = {
    redlib = {
      enable = true;
      port = 5462;
    };
    caddy = {
      enable = true;
      virtualHosts = {
        "lr.pwned.page".extraConfig = ''
          reverse_proxy http://localhost:5462
        '';
      };
    };
    cloudflare-dyndns.domains = [
      "lr.pwned.page"
    ];
  };
  security.acme.certs = {
    "lr.pwned.page" = {};
  };
}
