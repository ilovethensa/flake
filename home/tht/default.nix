# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{pkgs, ...}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    #inputs.nix-colors.homeManagerModules.default
    ./apps/vscode
    #./apps/firefox
    ../common/fish
    #./apps/yt-dlp
    #./apps/neovim
    #./apps/newsboat
    ./desktops/hyprland
    #spicetify-nix.homeManagerModule
    #inputs.nixvim.homeManagerModules.nixvim
  ];

  nixpkgs = {
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  # TODO: Set your username
  home = {
    username = "tht";
    homeDirectory = "/home/tht";
  };
 
  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];
  home.packages = with pkgs; [hashcat vesktop nixpkgs-fmt git-crypt yazi];
  programs = {
    home-manager.enable = true;
    git = {
      enable = true;
      userName = "Bill Gates";
      userEmail = "me@theholytachanka.com";
      extraConfig = {
        core.pager = "bat";
        init.defaultBranch = "main";
      };
    };
    ssh = {
      enable = true;
      extraConfig = ''
        Host ikaros
            HostName 192.168.1.111

        Host slash
            HostName 192.168.1.100

        Host viper
            HostName 192.168.1.102
      '';
    };
  }; 

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
