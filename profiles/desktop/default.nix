{
  inputs,
  outputs,
  ...
}: {
  imports = [
    ../common
    ../../nix/configs/sound.nix
    ../../nix/configs/nix-ld.nix
    inputs.home-manager.nixosModules.home-manager
  ];
  home-manager.extraSpecialArgs = {inherit inputs outputs;};
}
