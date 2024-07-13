{...}: {
  services.comin = {
    enable = true;
    remotes = [
      {
        name = "origin";
        url = "https://github.com/ilovethensa/dots";
        poller.period = 60;
        branches.main.name = "master";
      }
    ];
  };
  services.fwupd.enable = true;
}
