{...}: {
  virtualisation.oci-containers.containers."isso" = {
    image = "ghcr.io/isso-comments/isso";
    autoStart = true;
    ports = [
      "2645:2645"
    ];
    volumes = [
      "/etc/isso/:/config"
      "/mnt/data/isso:/db"
    ];
  };
  environment.etc."isso/isso.cfg".text = ''
    [general]
    dbpath = /db/comments.db
    host = https://theholytachanka.com
    [server]
    listen = http://localhost:2645
  '';
  services = {
    caddy = {
      virtualHosts = {
        "comments.theholytachanka.com".extraConfig = ''
          reverse_proxy http://localhost:2645
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
