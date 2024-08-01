{pkgs ? import <nixpkgs> {}, ...}: {
  # example = pkgs.callPackage ./example { };
  prismlauncher = pkgs.callPackage ./prismlauncher {};
}
