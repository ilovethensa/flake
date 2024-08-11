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
    amd = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.amd {
    environment = {
      variables = {
        ROC_ENABLE_PRE_VEGA = "1";
      };
      systemPackages = with pkgs; [
        clinfo
        rocmPackages_5.clr.icd
        rocmPackages_5.clr
        rocmPackages_5.rocminfo
        rocmPackages_5.rocm-runtime
      ];
    };
    # Additional hardware configurations
    services.xserver.videoDrivers = ["amdgpu"];
    boot.initrd.kernelModules = ["amdgpu"];
    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        rocmPackages_5.clr.icd
        rocmPackages_5.clr
        rocmPackages_5.rocminfo
        rocmPackages_5.rocm-runtime
      ];
    };
    systemd.tmpfiles.rules = [
      "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages_5.clr}"
    ];
  };
}
