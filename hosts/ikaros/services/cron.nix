{pkgs, ...}: let
  restart-podman = pkgs.writeShellScriptBin "restart-podman.sh" ''
    systemctl list-units | grep -o 'podman-[a-zA-Z0-9\-]*.service' | sort | uniq | while read -r unit; do
      echo "Restarting $unit"
      systemctl restart "$unit"
    done
  '';
  ssh-logs = pkgs.writeShellScriptBin "ssh-logs.sh" ''
mkdir /var/stats
{ echo "root $(grep -c 'Connection closed by authenticating user root' <(journalctl -xeu sshd))"; grep 'Invalid user' <(journalctl -xeu sshd) | awk '{print $8}' | sort | uniq -c | awk '{print $2, $1}'; } | sort -k2,2nr > /var/stats/users.txt
journalctl -xeu sshd | grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}' | grep -vE '^192\.' | sort | uniq -c | sort -nr | awk '{print $2, $1}' > /var/stats/ips.txt
  '';
in {
  services.cron = {
    enable = true;
    systemCronJobs = [
      "0 * /4 * * * ${restart-podman}"
      "0 * /4 * * * ${ssh-logs}"
    ];
  };
}
