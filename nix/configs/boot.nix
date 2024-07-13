{pkgs, ...}: {
  boot = {
    # Use a more optimized kernel
    kernelPackages = pkgs.linuxPackages_latest;
    # Enable systemd-boot
    loader = {
      systemd-boot = {
        enable = true;
        # Limit the number of generations to 5
        configurationLimit = 5;
        # Fix a security hole in place for backwards compatibility. See desc in
        # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/system/boot/loader/systemd-boot/systemd-boot.nix#L149
        editor = false;
      };
      efi.canTouchEfiVariables = true;
    };
    initrd.systemd.enable = true;
  };
  security.polkit.enable = true;
}
