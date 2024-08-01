{pkgs ? import <nixpkgs> {}, ...}: {
  # example = pkgs.callPackage ./example { };
  prismlauncher-cracked-unwrapped = pkgs.libsForQt5.callPackage ./prismlauncher-cracked-unwrapped {};
  prismlauncher-cracked- = pkgs.libsForQt5.callPackage ./prismlauncher-cracked {};
}
