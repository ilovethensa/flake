{inputs, ...}: {
  imports = [
    ../common
    ../../nix/services/openssh.nix
    inputs.agenix.nixosModules.default
  ];
}
