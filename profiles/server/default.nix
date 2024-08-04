{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ../common
    ../../nix/services/openssh.nix
    ../../nix/services/fail2ban.nix
    ../../nix/configs/hardening
    inputs.agenix.nixosModules.default
  ];
  boot.kernelPackages = pkgs.linuxKernel.kernels.linux_hardened;
}
