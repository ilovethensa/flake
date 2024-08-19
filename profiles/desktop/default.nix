{
  inputs,
  outputs,
  pkgs,
  ...
}: {
  imports = [
    ../common
    ../../nix/configs/sound.nix
    ../../nix/configs/nix-ld.nix
    ../../nix/configs/desktop/sway.nix
    inputs.home-manager.nixosModules.home-manager
  ];
  home-manager.extraSpecialArgs = {inherit inputs outputs;};
  environment.systemPackages = with pkgs; [
    nb
    btop
  ];
  
  services.pcscd.enable = true;
  services = {
    flatpak.enable = true;
    udisks2 = {
      enable = true;
      mountOnMedia = true;
    };
    devmon.enable = true;
    gvfs.enable = true;
    printing.enable = true;
    /*
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
    */
  };
  #boot.kernelPackages = pkgs.linuxPackages_latest;
  networking.firewall.allowedTCPPorts = [
  4455
  ];
}
