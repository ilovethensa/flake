{
  pkgs,
  inputs,
  ...
}: {
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    gamescopeSession.enable = true;
  };
  programs.gamemode.enable = true;
  environment.systemPackages = with pkgs;
    [
      protonup-qt
      mangohud
      wineWowPackages.stable
      wineWowPackages.waylandFull
      (lutris.override {
        extraLibraries = pkgs: [
          # List library dependencies here
        ];
        extraPkgs = pkgs: [
          # List package dependencies here
        ];
      })
    ]
    ++ [
      inputs.zvezda.packages.${pkgs.system}.prismlauncher-unwrapped
      pkgs.jdk17
    ];
}
