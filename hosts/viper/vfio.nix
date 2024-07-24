{...}: {
  virtualisation.libvirtd = {
    hooks = {
      qemu.win10 = ./libvirt-gpu-passthrough-hook.sh;
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
