{_}: {
  services.changedetection-io = {
    enable = true;
    playwrightSupport = true;
    port = 5000;
    chromePort = 3000;
  };

  networking.firewall.allowedTCPPorts = [
    5000
    3000
  ];
}
