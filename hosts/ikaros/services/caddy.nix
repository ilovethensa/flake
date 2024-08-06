{...}: {
  imports = [
    ../../../nix/services/caddy.nix
  ];
  # Secrets
  age.secrets.cloudflare_stuff.file = ../../../secrets/cloudflare_stuff.age;

  services.caddy = {
    virtualHosts = {
      "mc.theholytachanka.com".extraConfig = ''
        reverse_proxy http://localhost:25565
      '';
      "vpn.theholytachanka.com".extraConfig = ''
        reverse_proxy http://localhost:51821
      '';
      "mindustry.theholytachanka.com".extraConfig = ''
        reverse_proxy http://localhost:6567
      '';
      "request.theholytachanka.com".extraConfig = ''
        reverse_proxy http://localhost:5055
      '';
      "watch.theholytachanka.com".extraConfig = ''
        reverse_proxy http://localhost:8096
      '';
      "test.theholytachanka.com".extraConfig = ''
        respond "Hello, world!"
      '';
      "theholytachanka.com".extraConfig = ''
        encode gzip
        file_server
        root * /var/www/theholytachanka.com
      '';
      "http://localhost".extraConfig = ''
        encode gzip
        file_server
        root * /var/www/theholytachanka.com
      '';
      "http://127.0.0.1".extraConfig = ''
        encode gzip
        file_server
        root * /var/www/theholytachanka.com
      '';
      "pwned.page".extraConfig = ''
        encode gzip
        file_server
        root * /var/www/pwned.page
      '';
    };
  };

  services.cloudflare-dyndns.domains = [
    "mc.theholytachanka.com"
    "vpn.theholytachanka.com"
    "mindustry.theholytachanka.com"
    "test.theholytachanka.com"
    "theholytachanka.com"
    "pwned.page"
    "watch.theholytachanka.com"
    "request.theholytachanka.com"
  ];
  security.acme.certs = {
    "mc.theholytachanka.com" = {};
    "vpn.theholytachanka.com" = {};
    "mindustry.theholytachanka.com" = {};
    "test.theholytachanka.com" = {};
    "theholytachanka.com" = {};
    "pwned.page" = {};
    "watch.theholytachanka.com" = {};
    "request.theholytachanka.com" = {};
  };
}
