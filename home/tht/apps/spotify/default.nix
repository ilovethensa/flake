{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.spicetify-nix.homeManagerModules.default];
  programs.spicetify = let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  in {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      adblock
    ];
    enabledCustomApps = with spicePkgs.apps; [
      lyrics-plus
    ];
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";
  };
}
