{config, ...}: {
  services = {
    invidious = {
      enable = true;
      port = 4236;
      domain = "yt.pwned.page";
      database.createLocally = true;
      settings = {
        registration_enabled = false;
        login_enabled = true;
      };
    };
    caddy = {
      enable = true;
      virtualHosts = {
        "${config.services.invidious.domain}".extraConfig = ''
          reverse_proxy http://localhost:4236
        '';
      };
    };
    cloudflare-dyndns.domains = [
      "${config.services.invidious.domain}"
    ];
  };
  security.acme.certs = {
    "${config.services.invidious.domain}" = {};
  };
}
