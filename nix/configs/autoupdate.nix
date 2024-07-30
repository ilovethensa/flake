{_}: {
  services.comin = {
    enable = true;
    remotes = [
      {
        name = "origin";
        url = "https://github.com/ilovethensa/flake";
        branches.main.name = "main";
      }
    ];
  };
  services.fwupd.enable = true;
}
