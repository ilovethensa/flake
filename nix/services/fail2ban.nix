{...}: {
  services.fail2ban = {
    enable = true;
    # Ban IP after 5 failures
    maxretry = 5;
    ignoreIP = [
      "192.168.0.0/24"
    ];
    bantime = "24h"; # Ban IPs for one day on the first ban
    bantime-increment = {
      enable = true; # Enable increment of bantime after each violation
      multipliers = "1 2 4 8 16 32 64";
      maxtime = "168h"; # Do not ban for more than 1 week
      overalljails = true; # Calculate the bantime based on all the violations
    };
  };
}
