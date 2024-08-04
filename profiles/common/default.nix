{outputs, ...}: {
  imports = [
    ./openssh.nix
    ../../nix/options
    ../../nix/configs/secrets.nix
    ../../nix/configs/networking.nix
    ../../nix/configs/autoupdate.nix
    ../../nix/configs/boot.nix
    ../../nix/configs/nix.nix
    ../../nix/configs/oom.nix
    ../../nix/configs/zram.nix
    ../../nix/configs/podman.nix
  ];
  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
    ];
    config = {
      allowUnfree = true; # Enable unfree packages
    };
  };
}
