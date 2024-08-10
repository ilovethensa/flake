{
  pkgs,
  lib,
  config,
  ...
}: let
  service = "tht";
  cfg = config.${service};
in {
  options.${service} = {
    intel = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };
  imports = lib.optionals (lib.versionOlder lib.version "24.11pre") [
    (lib.mkAliasOptionModule ["hardware" "graphics" "enable"] ["hardware" "opengl" "enable"])
    (lib.mkAliasOptionModule ["hardware" "graphics" "extraPackages"] ["hardware" "opengl" "extraPackages"])
    (lib.mkAliasOptionModule ["hardware" "graphics" "extraPackages32"] ["hardware" "opengl" "extraPackages32"])
    (lib.mkAliasOptionModule ["hardware" "graphics" "enable32Bit"] ["hardware" "opengl" "driSupport32Bit"])
    (lib.mkAliasOptionModule ["hardware" "graphics" "package"] ["hardware" "opengl" "package"])
    (lib.mkAliasOptionModule ["hardware" "graphics" "package32"] ["hardware" "opengl" "package32"])
  ];
  config = lib.mkIf cfg.intel {
    nixpkgs.config.packageOverrides = pkgs: {
      vaapiIntel = pkgs.vaapiIntel.override {enableHybridCodec = true;};
    };
    hardware.graphics = {
      # hardware.opengl in 24.05
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver # For Broadwell (2014) or newer processors. LIBVA_DRIVER_NAME=iHD
        intel-vaapi-driver # previously vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
        intel-compute-runtime # OpenCL filter support (hardware tonemapping and subtitle burn-in)
        intel-media-sdk # QSV up to 11th gen
        intel-ocl # Intel OpenCL
      ];
    };
    environment.sessionVariables = {LIBVA_DRIVER_NAME = "iHD";}; # Optionally, set the environment variable
  };
}
