{
  lib,
  config,
  ...
}: let
  service = "meta";
  cfg = config.${service};
in {
  options.${service} = {
    persist = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf cfg.persist {
    environment.persistence."/nix/persist" = {
      hideMounts = true;
      directories = [
        "/var/log"
        "/var/lib/nixos"
        "/etc/NetworkManager/system-connections"
        "/var/lib/containers"
        "/etc/ssh"
      ];
    };
    environment.etc.machine-id = {
      text = ''
        12345678901234567890123456789012
      '';
    };
  };
}
