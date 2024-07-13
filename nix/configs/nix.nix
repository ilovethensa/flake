{
  lib,
  config,
  inputs,
  outputs,
  ...
}: {
  #programs.nh = {
  #  enable = true;
  #  clean.enable = true;
  #  clean.extraArgs = "--keep-since 3d --keep 3";
  #};
  nixpkgs = {
    config = {
      allowUnfree = true; # Enable unfree packages
    };
  };
  nix = {
    settings = {
      experimental-features = "nix-command flakes"; # Enable flakes and 'nix' command
      auto-optimise-store = true; # Deduplicate and optimize nix store
    };
    optimise = {
      automatic = true;
      dates = ["03:45"];
    };

    #nixPath = ["/etc/nix/path"];
    #registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);
  };
/*   environment.etc =
    lib.mapAttrs'
    (name: value: {
      name = "nix/path/${name}";
      value.source = value.flake;
    })
    config.nix.registry; */
}
