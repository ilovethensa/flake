{pkgs, ...}: let
  bookmark-add = pkgs.writeShellScriptBin "bookmark-add" ''
    # Get the URL from the user
    URL=$(rofi -dmenu -p "Enter Bookmark URL:")

    # Add the bookmark if URL is not empty
    [ -n "$URL" ] && nb "$URL" && rofi -e "Bookmark added!"
  '';
in {
  home.packages = with pkgs; [
    nb
  ];
  environment.systemPackages = [
    bookmark-add
  ];
}
