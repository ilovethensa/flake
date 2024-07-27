{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    impermanence.url = "github:nix-community/impermanence";
    nixarr.url = "github:rasmus-kirk/nixarr";
    nix-gaming.url = "github:fufexan/nix-gaming";
    agenix.url = "github:ryantm/agenix";
    comin.url = "github:nlewo/comin";
    simple-nixos-mailserver.url = "gitlab:simple-nixos-mailserver/nixos-mailserver";
    nixvim.url = "github:nix-community/nixvim";
    nix-colors.url = "github:misterio77/nix-colors";
    aagl.url = "github:ezKEa/aagl-gtk-on-nix";
    spicetify-nix.url = "github:the-argus/spicetify-nix";
  };
  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    impermanence,
    nixarr,
    nix-gaming,
    agenix,
    comin,
    simple-nixos-mailserver,
    home-manager,
    nixvim,
    nix-colors,
    aagl,
    spicetify-nix,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    nixosConfigurations.ikaros = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs outputs;};
      modules = [
        impermanence.nixosModules.impermanence
        comin.nixosModules.comin
        agenix.nixosModules.default
        nixarr.nixosModules.default
        simple-nixos-mailserver.nixosModule
        ./hosts/ikaros
      ];
    };
    nixosConfigurations.mute = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs outputs;};
      modules = [
        impermanence.nixosModules.impermanence
        comin.nixosModules.comin
        home-manager.nixosModules.home-manager
        ./hosts/mute
        {
          home-manager.extraSpecialArgs = {inherit nix-colors spicetify-nix inputs outputs;};
        }
      ];
    };
    nixosConfigurations.viper = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs outputs;};
      modules = [
        impermanence.nixosModules.impermanence
        comin.nixosModules.comin
        home-manager.nixosModules.home-manager
        ./hosts/viper
        {
          home-manager.extraSpecialArgs = {inherit nix-colors spicetify-nix inputs outputs;};
        }
      ];
    };
  };
}
