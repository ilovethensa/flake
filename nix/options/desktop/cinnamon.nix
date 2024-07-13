{
  lib,
  config,
  ...
}: let
  service = "meta";
  cfg = config.${service};
in {
  options.${service} = {
    cinnamon = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.cinnamon {
    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable the Cinnamon Desktop Environment.
    services.xserver.displayManager.lightdm.enable = true;
    services.xserver.desktopManager.cinnamon.enable = true;

    # Configure keymap in X11
    services.xserver = {
      layout = "us";
      xkbVariant = "";
    };
  };
}
