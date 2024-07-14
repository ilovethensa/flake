{inputs, ...}: {
  imports = [inputs.nixvim.homeManagerModules.nixvim];
  programs.nixvim = {
    enable = true;
    plugins.lightline.enable = true;
    colorschemes.gruvbox.enable = true;
  };
}
