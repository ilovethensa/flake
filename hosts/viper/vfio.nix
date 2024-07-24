{pkgs, ...}: {
  virtualisation.libvirtd = {
    hooks = {
      qemu.win10 = pkgs.writeShellScript "win10.sh" ''
        # Debugging
        set -x
        exec &>>/tmp/libvirt-hook
        # BASH_XTRACEFD=19
        date


        #
        #IOMMU Group 2:
        #	00:03.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h (Models 00h-1fh) PCIe Dummy Host Bridge [1022:1452]
        #	00:03.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Family 17h (Models 00h-0fh) PCIe GPP Bridge [1022:1453]
        #	09:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [AMD/ATI] Ellesmere [Radeon RX 470/480/570/570X/580/580X/590] [1002:67df] (rev e7)
        #	09:00.1 Audio device [0403]: Advanced Micro Devices, Inc. [AMD/ATI] Ellesmere HDMI Audio [Radeon RX 470/480 / 570/580/590] [1002:aaf0]

        VIRSH_GPU_VIDEO=pci_0000_09_00_0
        VIRSH_GPU_AUDIO=pci_0000_09_00_1

        GUEST_NAME=$1
        ACTION=$2
        STATE_NAME=$3

        if [ $GUEST_NAME != "$GUEST_NAME" ]; then
            echo "guest name does not match: $GUEST_NAME"
            exit 0
        fi

        if [ $ACTION = "prepare" ]; then
            # Isolate host to core 0
            #systemctl set-property --runtime -- user.slice AllowedCPUs=0
            #systemctl set-property --runtime -- system.slice AllowedCPUs=0
            #systemctl set-property --runtime -- init.scope AllowedCPUs=0

            # Stop display manager
            pkill -u tht

            # Unbind VTconsoles
            echo 0 > /sys/class/vtconsole/vtcon0/bind
            echo 0 > /sys/class/vtconsole/vtcon1/bind

            # Unbind EFI Framebuffer
            echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/unbind

            # Avoid race condition
            sleep 1

            # Unload amdgpu kernel modules
            while true; do
                modprobe -r amdgpu
                lsmod | grep -q amdgpu || break
                sleep 0.5
            done

            # Detach GPU devices from host
            virsh nodedev-detach $VIRSH_GPU_VIDEO
            virsh nodedev-detach $VIRSH_GPU_AUDIO

            # Load vfio module
            modprobe vfio-pci
        fi

        if [ $ACTION = "started" ]; then
            # this will try to reload the modules
            systemctl start coolercontrold.service
        fi

        if [ $ACTION = "release" ]; then
            # Unload vfio module
            modprobe -r vfio-pci

            # Attach GPU devices from host
            virsh nodedev-reattach $VIRSH_GPU_VIDEO
            virsh nodedev-reattach $VIRSH_GPU_AUDIO

            # Load amdgpu kernel modules
            modprobe -a amdgpu

            # Avoid race condition
            sleep 1

            # Bind EFI Framebuffer
            echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/bind

            # Bind VTconsoles
            echo 1 > /sys/class/vtconsole/vtcon0/bind
            echo 1 > /sys/class/vtconsole/vtcon1/bind

            # Start display manager
            #systemctl start display-manager.service

            # Return host to all cores
            #systemctl set-property --runtime -- user.slice AllowedCPUs=0-3
            #systemctl set-property --runtime -- system.slice AllowedCPUs=0-3
            #systemctl set-property --runtime -- init.scope AllowedCPUs=0-3

            # reinitialize coolercontrold to query gpu temp
            systemctl restart coolercontrold.service
        fi'';
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
