{
  inputs,
  outputs,
  spicetify-nix,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    spicetify-nix.nixosModule
  ];
  home-manager = {
    extraSpecialArgs = {inherit inputs outputs spicetify-nix;};
    users = {
      # Import your home-manager configuration
      mars = import ../../../home-manager/mars;
    };
  };
}
