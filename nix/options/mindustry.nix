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
    systemd.services.mindustry = {
      enable = true;
      description = "Mindustry server";
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.mindustry-server}/bin/mindustry-server host";
        NoNewPrivileges = true;
        PrivateTmp = true;
        PrivateDevices = true;
        PrivateUsers = true;
        DevicePolicy = "closed";
        ProtectSystem = "strict";
        ProtectHome = true;
        ProtectControlGroups = true;
        ProtectKernelModules = true;
        ProtectKernelTunables = true;
        RestrictAddressFamilies = "AF_UNIX AF_INET AF_INET6 AF_NETLINK";
        RestrictNamespaces = true;
        RestrictRealtime = true;
        RestrictSUIDSGID = true;
        MemoryDenyWriteExecute = true;
        LockPersonality = true;
      };
      wantedBy = ["network.target"];
    };

    networking.firewall = mkIf cfg.openFirewall {
      allowedTCPPorts = [6567];
      allowedUDPPorts = [6567];
    };
  };
}
