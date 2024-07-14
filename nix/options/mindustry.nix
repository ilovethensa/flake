{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services.mindustry-server;
in {
  options = {
    services.mindustry-server = {
      enable = mkEnableOption "Mindustry server";

      package = mkPackageOption pkgs "mindustry-server" {};

      openFirewall = mkOption {
        type = types.bool;
        default = false;
        description = "Open ports in the firewall for the mindustry server";
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.services.mindustry-server = {
      description = "Mindustry server";
      wantedBy = ["multi-user.target"];
      after = ["network.target"];
      serviceConfig = {
        ExecStart = "${lib.getExe cfg.package} host";
        Restart = "on-failure";
        RestartSec = "2s";
      };
    };

    networking.firewall = mkIf cfg.openFirewall {
      allowedTCPPorts = [6567];
      allowedUDPPorts = [6567];
    };
  };
}
