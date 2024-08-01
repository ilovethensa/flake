{pkgs ? import <nixpkgs> {}, ...}: {
  # example = pkgs.callPackage ./example { };
  prismlauncher-cracked = pkgs.libsForQt5.callPackage ./prismlauncher-cracked {};
}
