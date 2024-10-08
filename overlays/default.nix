# This file defines overlays
{...}: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs {pkgs = final;};

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    davinci-resolve = prev.davinci-resolve.override (old: {
      buildFHSEnv = a: (old.buildFHSEnv (a
        // {
          extraBwrapArgs =
            a.extraBwrapArgs
            ++ [
              "--bind /run/opengl-driver/etc/OpenCL /etc/OpenCL"
            ];
        }));
    });
  };
}
