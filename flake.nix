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
    nix-colors.url = "github:misterio77/nix-colors";
    aagl.url = "github:ezKEa/aagl-gtk-on-nix";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    firefox-addons.url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
    nixvim.url = "github:nix-community/nixvim";
    zvezda.url = "github:Kame03/ZvezdaLauncher";

    qutebrowser-catppucin = {
      url = "github:catppuccin/qutebrowser";
      flake = false;
    };
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
    home-manager,
    nix-colors,
    aagl,
    qutebrowser-catppucin,
    firefox-addons,
    nixvim,
    zvezda,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    nixosConfigurations = {
      ikaros = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs outputs;};
        modules = [
          comin.nixosModules.comin
          ./hosts/ikaros
        ];
      };
      mute = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs outputs;};
        modules = [
          comin.nixosModules.comin
          ./hosts/mute
        ];
      };
      viper = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs outputs;};
        modules = [
          comin.nixosModules.comin
          ./hosts/viper
        ];
      };
    };
  };
}
