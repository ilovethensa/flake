{pkgs, ...}: {
  environment.etc = {
    "libvirt/hooks/qemu.d/win10-gpu/release/end/revert.sh" = {
      mode = "0777";
      source = pkgs.writeShellScript "revert.sh" ''
        exec > /tmp/revert-log.txt 2>&1
        set -x

        # Re-Bind GPU to Nvidia Driver
        virsh nodedev-reattach pci_0000_07_00_1
        virsh nodedev-reattach pci_0000_07_00_0

        # Reload nvidia modules
        modprobe amdgpu

        # Rebind VT consoles
        echo 1 > /sys/class/vtconsole/vtcon0/bind
        # Some machines might have more than 1 virtual console. Add a line for each corresponding VTConsole
        #echo 1 > /sys/class/vtconsole/vtcon1/bind

        #nvidia-xconfig --query-gpu-info > /dev/null 2>&1
        #echo "efi-framebuffer.0" > /sys/bus/platform/drivers/efi-framebuffer/bind

        # Restart Display Manager
        #systemctl start display-manager.service
      '';
    };
    "libvirt/hooks/qemu.d/win10-gpu/prepare/begin/start.sh" = {
      mode = "0777";
      source = pkgs.writeShellScript "start.sh" ''
        exec > /tmp/start-log.txt 2>&1
        # Helpful to read output when debugging
        set -x

        # Stop display manager
        #systemctl stop display-manager.service
        ## Uncomment the following line if you use GDM
        #killall gdm-x-session
        ${pkgs.killall}/bin/killall sway
        pkill -u tht

        # Unbind VTconsoles
        echo 0 > /sys/class/vtconsole/vtcon0/bind
        echo 0 > /sys/class/vtconsole/vtcon1/bind

        # Unbind EFI-Framebuffer
        #echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/unbind

        # Avoid a Race condition by waiting 2 seconds. This can be calibrated to be shorter or longer if required for your system
        sleep 2

        # Unbind the GPU from display driver
        virsh nodedev-detach pci_0000_07_00_0
        virsh nodedev-detach pci_0000_07_00_1

        # Load VFIO Kernel Module
        modprobe vfio-pci
      '';
    };
    "libvirt/hooks/qemu" = {
      source = pkgs.writeShellScript "qemu" ''
        exec > /tmp/qemu-log.txt 2>&1
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
  };
}
