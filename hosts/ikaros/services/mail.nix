{
  config,
  lib,
  ...
}: {
  age.secrets.pass.file = ../../../secrets/pass.age;
  age.secrets.cloudflare_stuff.file = ../../../secrets/cloudflare_stuff.age;
  mailserver = {
    enable = true;
    fqdn = "mx.pwned.page";
    domains = ["pwned.page"];

    # A list of all login accounts. To create the password hashes, use
    # nix-shell -p mkpasswd --run 'mkpasswd -sm bcrypt'
    loginAccounts = {
      "tht@pwned.page" = {
        hashedPasswordFile = config.age.secrets.pass.path;
        aliases = ["postmaster@pwned.page"];
      };
    };

    # Use Let's Encrypt certificates. Note that this needs to set up a stripped
    # down nginx and opens port 80.
    certificateScheme = "acme-nginx";
  };
  services.roundcube = {
    enable = true;
    # this is the url of the vhost, not necessarily the same as the fqdn of
    # the mailserver
    hostName = "mail.example.com";
    extraConfig = ''
      # starttls needed for authentication, so the fqdn required to match
      # the certificate
      $config['smtp_server'] = "tls://${config.mailserver.fqdn}";
      $config['smtp_user'] = "%u";
      $config['smtp_pass'] = "%p";
    '';
  };

  services.nginx.enable = true;

  services.cloudflare-dyndns.domains = [
    "mx.pwned.page"
    "mail.pwned.page"
  ];
  security.acme = {
    acceptTerms = true;
    defaults.email = lib.mkForce "me@theholytachanka.com";
    defaults.dnsProvider = "cloudflare";
    defaults.environmentFile = config.age.secrets.cloudflare_stuff.path;
    certs = {
      "mc.theholytachanka.com" = {};
      "vpn.theholytachanka.com" = {};
      "mindustry.theholytachanka.com" = {};
      "test.theholytachanka.com" = {};
      "theholytachanka.com" = {};
      "pwned.page" = {};
      "watch.theholytachanka.com" = {};
      "request.theholytachanka.com" = {};
      "mail.pwned.page" = {};
      "mx.pwned.page" = {};
    };
  };
  networking.firewall = {
    allowedTCPPorts = [
      8080
      25
      587
      465
      143
      993
      4190
      110
      995
    ];
    allowedUDPPorts = [
      8080
      25
      587
      465
      143
      993
      4190
      110
      995
    ];
  };
}
