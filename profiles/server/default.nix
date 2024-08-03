{inputs, ...}: {
  imports = [
    ../common
    ../../nix/services/openssh.nix
    ../../nix/services/fail2ban.nix
    inputs.agenix.nixosModules.default
  ];
}
