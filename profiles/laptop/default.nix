{_}: {
  imports = [
    ../common
    ../desktop
    ../../nix/configs/battery.nix
  ];
  programs.light.enable = true;
}
