{pkgs, ...}: {
  programs.fish.enable = true;
  users = {
    defaultUserShell = pkgs.fish;
    users = {
      mars = {
        isNormalUser = true;
        description = "mars";
        extraGroups = ["networkmanager" "wheel"];
        packages = with pkgs; [
          firefox
          #  thunderbird
        ];
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBPxwPORGfx1bD9W6Dq0AOkxwlx1eO7AHdO1LhhA9I/n tht" # content of authorized_keys file
          # note: ssh-copy-id will add user@your-machine after the public key
          # but we can remove the "@your-machine" part
        ];
      };
      root = {
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBPxwPORGfx1bD9W6Dq0AOkxwlx1eO7AHdO1LhhA9I/n tht" # content of authorized_keys file
          # note: ssh-copy-id will add user@your-machine after the public key
          # but we can remove the "@your-machine" part
        ];
        initialHashedPassword = "$6$dO.lQ2bJZ5PBNhju$WXDIMEWtKFSTw94iRX7Pi2HwsN6hw2q4k3D6UxJXUdMm1VsrtrqpbC/4iyiOBhU.fxWKkugP30s.RuK6IYbWN.";
      };
    };
  };
}
