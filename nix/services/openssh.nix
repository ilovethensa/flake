{...}: {
  services.openssh = {
    enable = true;
    # require public key authentication for better security
    settings.PasswordAuthentication = true;
    settings.KbdInteractiveAuthentication = true;
    settings.PermitRootLogin = "yes";
  };
  networking.firewall.allowedTCPPorts = [
    22 # ssh port
  ];
}
