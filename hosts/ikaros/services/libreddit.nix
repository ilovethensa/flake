{_}: {
  services = {
    libreddit = {
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
    acme.certs = {
      "lr.pwned.page" = {};
    };
  };
}
