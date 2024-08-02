# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];
  boot = {
    initrd = {
      availableKernelModules = ["xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod"];
      kernelModules = [];
    };
    kernelModules = ["kvm-intel"];
    extraModulePackages = [];
  };

  fileSystems = {
    "/" = {
      device = "none";
      fsType = "tmpfs";
      options = ["defaults" "size=4G" "mode=755"];
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/9333-E11B";
      fsType = "vfat";
    };
    #"/home" = {
    #  device = "/dev/disk/by-uuid/893f5d89-f0eb-4168-bccb-d604472fe9ad";
    #  fsType = "btrfs";
    #  options = ["subvol=@home" "compress-force=zstd:15" "defaults" "noatime" "nofail"];
    #};
    "/nix" = {
      device = "/dev/disk/by-uuid/893f5d89-f0eb-4168-bccb-d604472fe9ad";
      fsType = "btrfs";
      options = ["subvol=@nix" "compress-force=zstd:15" "defaults" "noatime"];
    };
    "/mnt/media" = {
      device = "/dev/disk/by-uuid/23fc1491-b1f6-4e69-82e7-6135e4c0a3f1";
      fsType = "btrfs";
      options = ["compress-force=zstd:15" "defaults" "noatime" "autodefrag" "nofail"];
    };
    "/mnt/data" = {
      device = "/dev/disk/by-uuid/4df05109-d59f-4417-ae8f-75a7dbb836b5";
      #fsType = "btrfs";
      options = ["defaults" "nofail"];
    };
    "/srv/data" = {
      depends = [
        # The mounts above have to be mounted in this given order
        "/mnt/data"
      ];
      device = "/mnt/data";
      fsType = "none";
      options = [
        "bind"
        "nofail"
      ];
    };
    "/srv/Media" = {
      depends = [
        # The mounts above have to be mounted in this given order
        "/mnt/media"
      ];
      device = "/mnt/media";
      fsType = "none";
      options = [
        "bind"
        "nofail"
      ];
    };
  };

  swapDevices = [];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s31f6.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
