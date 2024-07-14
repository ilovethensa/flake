{pkgs, ...}: let
  restart-podman = pkgs.writeShellScriptBin "restart-podman.sh" ''
    systemctl list-units | grep -o 'podman-[a-zA-Z0-9\-]*.service' | sort | uniq | while read -r unit; do
      echo "Restarting $unit"
      systemctl restart "$unit"
    done
  '';
in {
  services.cron = {
    enable = true;
    systemCronJobs = [
      "0 * /4 * * * ${restart-podman}"
    ];
  };
}
