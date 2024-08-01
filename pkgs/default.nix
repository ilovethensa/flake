{pkgs ? import <nixpkgs> {}, ...}: {
  # example = pkgs.callPackage ./example { };
  prismlauncher-cracked = pkgs.callPackage ./prismlauncher-cracked {};
}
