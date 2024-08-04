{inputs, ...}: {
  imports = [
    ../common
    ../../nix/services/openssh.nix
    ../../nix/services/fail2ban.nix
    ../../nix/configs/hardening
    inputs.agenix.nixosModules.default
  ];
}
