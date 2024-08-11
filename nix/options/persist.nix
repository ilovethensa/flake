{
  lib,
  config,
  inputs,
  ...
}: let
  service = "tht";
  cfg = config.${service};
in {
  options.${service} = {
    persist = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];

  config = lib.mkIf cfg.persist {
    environment.persistence."/nix/persist" = {
      hideMounts = true;
      directories = [
        "/var/log"
        "/var/lib/comin/" # Else comin doesnt work
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
