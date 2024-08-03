{pkgs, ...}: {
  services.mindustry-server = {
    enable = true;
    openFirewall = true;
  };
  services.cloudflare-dyndns.domains = [
    "mindustry.theholytachanka.com"
  ];
}
