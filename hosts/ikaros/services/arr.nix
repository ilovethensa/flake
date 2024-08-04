{inputs, ...}: {
  imports = [
    inputs.nixarr.nixosModules.default
  ];
  nixarr = {
    enable = true;
    mediaDir = "/mnt/media";
    stateDir = "/mnt/data";

    jellyfin = {
      enable = true;
      openFirewall = true;
    };
    transmission = {
      enable = true;
      peerPort = 32456;
      flood.enable = true;
      openFirewall = true;
    };
    bazarr = {
      enable = true;
      openFirewall = true;
    };
    prowlarr = {
      enable = true;
      openFirewall = true;
    };
    radarr = {
      enable = true;
      openFirewall = true;
    };
    sonarr = {
      enable = true;
      openFirewall = true;
    };
  };
  systemd.services = {
    bazarr.serviceConfig = {
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
      ReadWritePaths = "/mnt/data/bazarr /mnt/media/library";
      ProtectClock = true;
      ProtectHostname = true;
      RemoveIPC = true;
      KeyringMode = "private";
      SystemCallArchitectures = "native";
      ProtectProc = "invisible";
      ProcSubset = "pid";
      SystemCallFilter = ["@system-service" "~@privileged" "~@resources"];
      DeviceAllow = [""];
    };
    prowlarr.serviceConfig = {
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
      LockPersonality = true;
      ReadWritePaths = "/mnt/data/prowlarr";
      ProtectClock = true;
      ProtectHostname = true;
      RemoveIPC = true;
      KeyringMode = "private";
      SystemCallArchitectures = "native";
      ProtectProc = "invisible";
      ProcSubset = "pid";
      SystemCallFilter = ["@system-service" "~@privileged" "~@resources"];
      DeviceAllow = [""];
    };
    radarr.serviceConfig = {
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
      LockPersonality = true;
      ReadWritePaths = "/mnt/data/radarr /mnt/media";
      ProtectClock = true;
      ProtectHostname = true;
      RemoveIPC = true;
      KeyringMode = "private";
      SystemCallArchitectures = "native";
      ProtectProc = "invisible";
      ProcSubset = "pid";
      SystemCallFilter = ["@system-service" "~@privileged" "~@resources"];
      DeviceAllow = [""];
    };
    sonarr.serviceConfig = {
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
      LockPersonality = true;
      ReadWritePaths = "/mnt/data/sonarr /mnt/media";
      ProtectClock = true;
      ProtectHostname = true;
      RemoveIPC = true;
      KeyringMode = "private";
      SystemCallArchitectures = "native";
      ProtectProc = "invisible";
      ProcSubset = "pid";
      #SystemCallFilter = ["@system-service" "~@privileged" "~@resources"];
      DeviceAllow = [""];
    };
  };
  networking.firewall.allowedTCPPorts = [
    3119 # Peer port
  ];
}
