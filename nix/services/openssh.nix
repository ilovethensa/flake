{_}: {
  services.openssh = {
    enable = true;
    # require public key authentication for better security
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "yes";
    };
  };
  networking.firewall.allowedTCPPorts = [
    22 # ssh port
  ];
}
