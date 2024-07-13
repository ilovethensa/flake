{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    impermanence.url = "github:nix-community/impermanence";
    nixarr.url = "github:rasmus-kirk/nixarr";
    nix-gaming.url = "github:fufexan/nix-gaming";
    agenix.url = "github:ryantm/agenix";
    comin.url = "github:nlewo/comin";
    simple-nixos-mailserver.url = "gitlab:simple-nixos-mailserver/nixos-mailserver";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    impermanence,
    nixarr,
    nix-gaming,
    agenix,
    comin,
    simple-nixos-mailserver,
    home-manager,
    ...
  } @ attrs: {
    nixosConfigurations.ikaros = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [
        impermanence.nixosModules.impermanence
        comin.nixosModules.comin
        agenix.nixosModules.default
        ./hosts/ikaros
      ];
    };
    nixosConfigurations.mute = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [
        ./hosts/mute
      ];
    };
  };
}
