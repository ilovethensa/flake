{
  inputs,
  outputs,
  ...
}: {
  imports = [
    ../common
    ../../nix/configs/sound.nix
    inputs.home-manager.nixosModules.home-manager
  ];
  home-manager.extraSpecialArgs = {inherit inputs outputs;};
}
