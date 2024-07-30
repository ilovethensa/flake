{_}: {
  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;

    # Enable the Cinnamon Desktop Environment.
    displayManager.lightdm.enable = true;
    desktopManager.cinnamon.enable = true;

    # Configure keymap in X11
    layout = "us";
    xkbVariant = "";
  };
}
