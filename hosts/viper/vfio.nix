{pkgs, ...}: {
  virtualisation.libvirtd = {
    hooks = {
      qemu = {
        "win10/prepare/begin" = pkgs.writeShellScriptBin "win10up" ''
          set -x

          # Stop display manager
          systemctl stop display-manager
          # systemctl --user -M YOUR_USERNAME@ stop plasma*

          # Unbind VTconsoles: might not be needed
          echo 0 > /sys/class/vtconsole/vtcon0/bind
          echo 0 > /sys/class/vtconsole/vtcon1/bind

          # Unbind EFI Framebuffer
          echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/unbind

          # Unload NVIDIA kernel modules
          #modprobe -r nvidia_drm nvidia_modeset nvidia_uvm nvidia

          # Unload AMD kernel module
          modprobe -r amdgpu

          # Detach GPU devices from host
          # Use your GPU and HDMI Audio PCI host device
          virsh nodedev-detach pci_0000_01_00_0
          virsh nodedev-detach pci_0000_01_00_1

          # Load vfio module
          modprobe vfio-pci'';
        "win10/release/end" = pkgs.writeShellScriptBin "win10down" ''
          set -x

          # Attach GPU devices to host
          # Use your GPU and HDMI Audio PCI host device
          virsh nodedev-reattach pci_0000_01_00_0
          virsh nodedev-reattach pci_0000_01_00_1

          # Unload vfio module
          modprobe -r vfio-pci

          # Load AMD kernel module
          modprobe amdgpu

          # Rebind framebuffer to host
          echo "efi-framebuffer.0" > /sys/bus/platform/drivers/efi-framebuffer/bind

          # Load NVIDIA kernel modules
          #modprobe nvidia_drm
          #modprobe nvidia_modeset
          #modprobe nvidia_uvm
          #modprobe nvidia

          # Bind VTconsoles: might not be needed
          echo 1 > /sys/class/vtconsole/vtcon0/bind
          echo 1 > /sys/class/vtconsole/vtcon1/bind

          # Restart Display Manager
          systemctl start display-manager
        '';
      };
    };
  };
  environment.etc."libvirt/hooks/qemu" = {
    mode = "0555";
    text = ''
      GUEST_NAME="$1"
      HOOK_NAME="$2"
      STATE_NAME="$3"
      MISC="$\{@:4}"

      BASEDIR="$(dirname $0)"

      HOOKPATH="$BASEDIR/qemu.d/$GUEST_NAME/$HOOK_NAME/$STATE_NAME"
      set -e # If a script exits with an error, we should as well.

      if [ -f "$HOOKPATH" ]; then
      eval \""$HOOKPATH"\" "$@"
      elif [ -d "$HOOKPATH" ]; then
      while read file; do
        eval \""$file"\" "$@"
      done <<< "$(find -L "$HOOKPATH" -maxdepth 1 -type f -executable -print;)"
      fi
    '';
  };
  
}
