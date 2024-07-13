{
  pkgs,
  lib,
  config,
  ...
}: let
  service = "meta";
  cfg = config.${service};
in {
  options.${service} = {
    intel = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.intel {
    hardware.graphics = {
      # hardware.opengl in 24.05
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver # For Broadwell (2014) or newer processors. LIBVA_DRIVER_NAME=iHD
        vpl-gpu-rt # or intel-media-sdk for QSV
      ];
    };
    environment.sessionVariables = {LIBVA_DRIVER_NAME = "iHD";}; # Optionally, set the environment variable
  };
}
