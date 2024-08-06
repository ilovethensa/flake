{
  config,
  lib,
  ...
}: {
  # Secrets
  age.secrets.cloudflare_stuff.file = ../../secrets/cloudflare_stuff.age;

  services.caddy = {
    enable = true;
    globalConfig = ''
      auto_https disable_redirects
    '';
  };

  services.cloudflare-dyndns = {
    enable = true;
    apiTokenFile = config.age.secrets.cloudflare_stuff.path;
  };
  security.acme = {
    acceptTerms = true;
    defaults = {
      email = lib.mkForce "me@theholytachanka.com";
      dnsProvider = "cloudflare";
      environmentFile = config.age.secrets.cloudflare_stuff.path;
    };
  };
  networking.firewall.allowedTCPPorts = [
    443
    80
  ];
  environment.persistence."/nix/persist".directories = [
    "/var/www"
  ];
}
