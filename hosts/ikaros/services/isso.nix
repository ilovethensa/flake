{...}: {
  services = {
    isso = {
      enable = true;
      settings = {
        general = {
          dbpath = "/mnt/data/isso/comments.db";
          host = "https://theholytachanka.com";
        };
        server = {
          listen = "http://localhost:7445";
        };
      };
    };
    caddy = {
      virtualHosts = {
        "comments.theholytachanka.com".extraConfig = ''
          reverse_proxy http://localhost:7445
        '';
      };
    };
    cloudflare-dyndns.domains = [
      "comments.theholytachanka.com"
    ];
  };
  security.acme.certs = {
    "comments.theholytachanka.com" = {};
  };
}
