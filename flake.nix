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
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    simple-nixos-mailserver.url = "gitlab:simple-nixos-mailserver/nixos-mailserver";

    qutebrowser-catppucin = {
      url = "github:catppuccin/qutebrowser";
      flake = false;
    };
    morewaita = {
      url = "github:somepaulo/MoreWaita";
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
    nix-flatpak,
    simple-nixos-mailserver,
    morewaita,
    ...
  } @ inputs: let
    inherit (self) outputs;
    # Supported systems for your flake packages, shell, etc.
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = nixpkgs.lib.genAttrs systems;
    #secrets = builtins.fromJSON (builtins.readFile "${self}/secrets.json");
  in {
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    overlays = import ./overlays {inherit inputs;};
    templates = import ./templates;
    nixosConfigurations = {
      ikaros = nixpkgs-stable.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          comin.nixosModules.comin
          ./hosts/ikaros
        ];
      };
      ace = nixpkgs-stable.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          comin.nixosModules.comin
          ./hosts/ace
        ];
      };
      mute = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          comin.nixosModules.comin
          ./hosts/mute
        ];
      };
      viper = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          comin.nixosModules.comin
          ./hosts/viper
        ];
      };
    };
  };
}
