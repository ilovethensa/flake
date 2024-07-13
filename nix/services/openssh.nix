{lib, ...}: {
  services.openssh = {
    enable = true;
    # require public key authentication for better security
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
    settings.PermitRootLogin = "yes";
  };
  environment.etc = {
    "ssh/sshd_config".text = lib.mkForce ''
    '';
  };
}
