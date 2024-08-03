{pkgs, ...}: {
  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs;
    libraries = [
      # Add any missing dynamic libraries for unpackaged
      # programs here, NOT in environment.systemPackages
    ];
  };
}
