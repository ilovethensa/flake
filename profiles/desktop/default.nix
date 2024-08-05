{
  inputs,
  outputs,
  ...
}: {
  imports = [
    ../common
    ../../nix/configs/sound.nix
    ../../nix/configs/nix-ld.nix
    inputs.home-manager.nixosModules.home-manager
  ];
  home-manager.extraSpecialArgs = {inherit inputs outputs;};
  services = {
    flatpak.enable = true;
    udisks2 = {
      enable = true;
      mountOnMedia = true;
    };
    lokinet = {
      enable = true;
      useLocally = true;
      settings = {
        dns = {
          bind = "127.3.2.1";
          upstream = ["193.110.81.0" "185.253.5.0"];
        };

        network.exit-node = ["exit.loki"];
      };
    };
  };
}
