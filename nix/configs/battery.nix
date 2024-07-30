{...}: {
  services = {
    power-profiles-daemon.enable = false;
    tlp.enable = false;
    auto-cpufreq = {
      enable = false;
      settings = {
        battery = {
          governor = "powersave";
          turbo = "never";
        };
        charger = {
          governor = "performance";
          turbo = "auto";
        };
      };
    };
  };
  powerManagement.powertop.enable = false;
}
