{...}: {
  imports = [
    #./kernel.nix
    #./systemd.nix
  ];
  # Only allow members of the wheel group to execute sudo
  security.sudo.execWheelOnly = true;
}
