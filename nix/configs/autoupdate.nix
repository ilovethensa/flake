{...}: {
  services.comin = {
    enable = true;
    remotes = [
      {
        name = "origin";
        url = "https://github.com/ilovethensa/flake";
        poller.period = 60;
        branches.main.name = "main";
      }
    ];
  };
  services.fwupd.enable = true;
}
