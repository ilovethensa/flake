# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  pkgs,
  inputs,
  ...
}: {
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
    ./apps/spotify
    #./apps/qutebrowser
    ./apps/firefox
    ../common/fish
    #./apps/yt-dlp
    ./apps/neovim
    #./apps/newsboat
    ./apps/yazi
    ./desktops/sway
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
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
  home.packages = with pkgs; [hashcat vesktop nixpkgs-fmt signal-desktop thunderbird bitwarden ungoogled-chromium bisq-desktop];
  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gtk2;
    enableSshSupport = true;
  };
  programs = {
    gpg.enable = true;
    home-manager.enable = true;
    git = {
      enable = true;
      userName = "John";
      userEmail = "me@theholytachanka.com";
      signing = {
        signByDefault = true;
        key = null;
      };
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
  home.file = {
    ".config/libvirt/qemu.conf" = {
      text = ''
        # Adapted from /var/lib/libvirt/qemu.conf
        # Note that AAVMF and OVMF are for Aarch64 and x86 respectively
        nvram = [ "/run/libvirt/nix-ovmf/AAVMF_CODE.fd:/run/libvirt/nix-ovmf/AAVMF_VARS.fd", "/run/libvirt/nix-ovmf/OVMF_CODE.fd:/run/libvirt/nix-ovmf/OVMF_VARS.fd" ]'';
    };
  };
    programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-vkcapture
      obs-pipewire-audio-capture
    ];
  };
  services.flatpak.packages = [
    "com.ultimaker.cura"
    "net.mkiol.SpeechNote"
  ];
  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
