{
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.simple-nixos-mailserver.nixosModule
  ];
  age.secrets.cloudflare_stuff.file = ../../../secrets/cloudflare_stuff.age;
  mailserver = {
    enable = true;
    fqdn = "mail.pwned.page";
    domains = ["pwned.page"];

    loginAccounts = {
      "tht@pwned.page" = {
        hashedPasswordFile = config.age.secrets.cloudflare_stuff.path;
        aliases = ["postmaster@pwned.page"];
      };
    };
    mailDirectory = "/mnt/data/email/mail";
    dkimKeyDirectory = "/mnt/data/email/dkim";
    openFirewall = true;
    

    # Use Let's Encrypt certificates. Note that this needs to set up a stripped
    # down nginx and opens port 80.
    certificateScheme = "acme";
  };
  services = {
    caddy = {
      enable = true;
      virtualHosts = {
        "mail.pwned.page".extraConfig = ''
        '';
      };
    };
    cloudflare-dyndns.domains = [
      "mail.pwned.page"
    ];
  };
  security.acme.certs = {
    "mail.pwned.page" = {};
  };
}
