{pkgs, ...}: {
  programs.fish.enable = true;
  users = {
    defaultUserShell = pkgs.fish;
    mutableUsers = false;
    users = {
      root = {
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO1TqzsM18I70A0XhmBjYhryhkRFdGl6ofup92N3XNyC tht" # content of authorized_keys file\
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBPxwPORGfx1bD9W6Dq0AOkxwlx1eO7AHdO1LhhA9I/n tht"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIICZPbS3Jf+N2MmVD1n+qJfbLGVUGGpRH0BJvpU+ECR5 u0_a169"
          # note: ssh-copy-id will add user@your-machine after the public key
          # but we can remove the "@your-machine" part
        ];
        initialHashedPassword = "$6$dO.lQ2bJZ5PBNhju$WXDIMEWtKFSTw94iRX7Pi2HwsN6hw2q4k3D6UxJXUdMm1VsrtrqpbC/4iyiOBhU.fxWKkugP30s.RuK6IYbWN.";
      };
      tht = {
        isNormalUser = true;
        extraGroups = ["wheel" "render" "video" "docker" "adbusers" "gamemode" "libvirtd"]; # Enable ‘sudo’ for the user.
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO1TqzsM18I70A0XhmBjYhryhkRFdGl6ofup92N3XNyC tht" # content of authorized_keys file
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBPxwPORGfx1bD9W6Dq0AOkxwlx1eO7AHdO1LhhA9I/n tht"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIICZPbS3Jf+N2MmVD1n+qJfbLGVUGGpRH0BJvpU+ECR5 u0_a169"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO1TqzsM18I70A0XhmBjYhryhkRFdGl6ofup92N3XNyC tht"

          # note: ssh-copy-id will add user@your-machine after the public key
          # but we can remove the "@your-machine" part
        ];

        initialHashedPassword = "$6$dO.lQ2bJZ5PBNhju$WXDIMEWtKFSTw94iRX7Pi2HwsN6hw2q4k3D6UxJXUdMm1VsrtrqpbC/4iyiOBhU.fxWKkugP30s.RuK6IYbWN.";
      };
    };
  };
  # don't install documentation i don't use
  documentation.enable = false; # documentation of packages
  documentation.nixos.enable = false; # nixos documentation
  documentation.man.enable = false; # manual pages and the man command
  documentation.info.enable = false; # info pages and the info command
  documentation.doc.enable = false; # documentation distributed in packages' /share/doc
}
