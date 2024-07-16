{inputs, ...}: {
  imports = [inputs.nixvim.homeManagerModules.nixvim];
  programs.nixvim = {
    enable = true;
    colorschemes.cyberdream.enable = true;
    plugins = {
      neo-tree.enable = true;
      lightline.enable = true;
      nix.enable = true;
      clangd-extensions.enable = true;
      rustaceanvim.enable = true;
      rust-tools.enable = true;
      wtf.enable = true;
      lsp-lines.enable = true;
      lsp-status.enable = true;
      lsp-format.enable = true;
      inc-rename.enable = true;
      lsp = {
        enable = true;
        servers = {
          rust-analyzer = {
            enable = true;
            installCargo = true;
            installRustc = true;
          };
          pylsp.enable = true;
        };
      };
    };
  };
}
