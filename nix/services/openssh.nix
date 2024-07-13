{...}: {
  services.openssh = {
    enable = true;
    ports = [
      22
    ];
    banner = ''
      ----------------------------------------------------------------------
      |                      Official CIA spyware node                     |
      |                                                                    |
      |  This system can only by accessed by the SSH backdoor our friends  |
      |  at the NSA gave us, no other way is possible. If you dont have it |
      |  Please contact your authoritives                                  |
      |                                                                    |
      |  All activities performed on this system are logged and monitored. |
      ----------------------------------------------------------------------
    '';
    # require public key authentication for better security
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "yes";
      LogLevel = "VERBOSE";
      Ciphers = [
        "aes256-gcm@openssh.com"
        "aes256-ctr,aes192-ctr"
        "aes128-ctr"
        "aes128-gcm@openssh.com"
        "chacha20-poly1305@openssh.com"
      ];
      KexAlgorithms = [
        "curve25519-sha256"
        "curve25519-sha256@libssh.org"
        "diffie-hellman-group16-sha512"
        "diffie-hellman-group18-sha512"
        "sntrup761x25519-sha512@openssh.com"
      ];
      Macs = [
        "hmac-sha2-512-etm@openssh.com"
        "hmac-sha2-256-etm@openssh.com"
        "umac-128-etm@openssh.com"
      ];
      X11Forwarding = false;
    };
  };
  # Timeout TTY after 1 hour
  programs.bash.interactiveShellInit = "if [[ $(tty) =~ /dev\\/tty[1-6] ]]; then TMOUT=3600; fi";
  services.fail2ban = {
    enable = true;
    # Ban IP after 5 failures
    maxretry = 5;
    bantime = "24h"; # Ban IPs for one day on the first ban
    bantime-increment = {
      enable = true; # Enable increment of bantime after each violation
      multipliers = "1 2 4 8 16 32 64";
      maxtime = "168h"; # Do not ban for more than 1 week
      overalljails = true; # Calculate the bantime based on all the violations
    };
  };
  networking.firewall.allowedTCPPorts = [
    22
  ];
}
