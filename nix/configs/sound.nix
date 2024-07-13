{
  lib,
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.nix-gaming.nixosModules.pipewireLowLatency
  ];
  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    lowLatency = {
      enable = true;
      quantum = 64;
      rate = 48000;
    };
  };
  config = lib.mkIf config.meta.persist {
    environment.persistence."/nix/persist".directories = [
      "/var/lib/alsa"
    ];
  };
}
