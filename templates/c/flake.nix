{
  description = "A template for Nix based C++ project setup.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";

    utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs:
    inputs.utils.lib.eachSystem [
      # Add the system/architecture you would like to support here. Note that not
      # all packages in the official nixpkgs support all platforms.
      "x86_64-linux"
      "i686-linux"
      "aarch64-linux"
      "x86_64-darwin"
    ] (system: let
      pkgs = import nixpkgs {
        inherit system;

        # Add overlays here if you need to override the nixpkgs
        # official packages.
        overlays = [];

        # Uncomment this if you need unfree software (e.g. cuda) for
        # your project.
        #
        # config.allowUnfree = true;
      };
    in {
      devShells.default = pkgs.mkShell rec {
        # Update the name to something that suites your project.
        name = "my-c++-project";

        packages = with pkgs; [
          # Development Tools
          llvmPackages_18.clang
          gnumake
          clang-analyzer
          # Build time and Run time dependencies
          mold
        ];

        # Setting up the environment variables you need during
        # development.
        shellHook = let
          icon = "f121";
        in ''
          export PS1="$(echo -e '\u${icon}') {\[$(tput sgr0)\]\[\033[38;5;228m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]} (${name}) \\$ \[$(tput sgr0)\]"
        '';
      };

      packages.default = pkgs.callPackage ./default.nix {};
    });
}
