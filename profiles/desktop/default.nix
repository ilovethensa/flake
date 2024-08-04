{
  inputs,
  outputs, pkgs,
  ...
}: {
  imports = [
    ../common
    ../../nix/configs/sound.nix
    ../../nix/configs/nix-ld.nix
    inputs.home-manager.nixosModules.home-manager
  ];
  home-manager.extraSpecialArgs = {inherit inputs outputs;};
  services.udisks2 = {
    enable = true;
    mountOnMedia = true;
  };
  services.flatpak.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
