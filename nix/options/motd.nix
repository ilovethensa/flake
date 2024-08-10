{
  config,
  lib,
  pkgs,
  ...
}: let
  check-services = pkgs.writeShellScriptBin "check-services" ''
    # Color codes
    ACTIVE="\033[0;32m"  # Green
    INACTIVE="\033[0;31m" # Red
    RESET="\033[0m"      # Reset

    for svc in "$@"; do
        status=$(systemctl is-active "$svc" 2>/dev/null)
        case $status in
            active)
                color=$ACTIVE
                ;;
            *)
                color=$INACTIVE
                ;;
        esac
        printf "%-30s [%s%s%s]\n" "$svc" "$color" "$status" "$RESET"
    done
  '';
  motd =
    pkgs.writeShellScriptBin "motd"
    ''
      source /etc/os-release
      service_status=$(systemctl list-units | grep podman-)
      RED="\e[31m"
      GREEN="\e[32m"
      BOLD="\e[1m"
      ENDCOLOR="\e[0m"
      LOAD1=`cat /proc/loadavg | awk {'print $1'}`
      LOAD5=`cat /proc/loadavg | awk {'print $2'}`
      LOAD15=`cat /proc/loadavg | awk {'print $3'}`

      MEMORY=`free -m | awk 'NR==2{printf "%s/%sMB (%.2f%%)\n", $3,$2,$3*100 / $2 }'`

      # time of day
      HOUR=$(date +"%H")
      if [ $HOUR -lt 12  -a $HOUR -ge 0 ]
      then    TIME="morning"
      elif [ $HOUR -lt 17 -a $HOUR -ge 12 ]
      then    TIME="afternoon"
      else
          TIME="evening"
      fi


      uptime=`cat /proc/uptime | cut -f1 -d.`
      upDays=$((uptime/60/60/24))
      upHours=$((uptime/60/60%24))
      upMins=$((uptime/60%60))
      upSecs=$((uptime%60))

      figlet "$(hostname)" | lolcat -f
      printf "$BOLD    %-20s$ENDCOLOR %s\n" "Role:" "Server"
      printf "\n"
      ${lib.strings.concatStrings (lib.lists.forEach cfg.networkInterfaces (x: "printf \"$BOLD  * %-20s$ENDCOLOR %s\\n\" \"IPv4 ${x}\" \"$(ip -4 addr show ${x} | grep -oP '(?<=inet\\s)\\d+(\\.\\d+){3}')\"\n"))}
      printf "$BOLD  * %-20s$ENDCOLOR %s\n" "Release" "$PRETTY_NAME"
      printf "$BOLD  * %-20s$ENDCOLOR %s\n" "Kernel" "$(uname -rs)"
      [ -f /var/run/reboot-required ] && printf "$RED  * %-20s$ENDCOLOR %s\n" "A reboot is required"
      printf "\n"
      printf "$BOLD  * %-20s$ENDCOLOR %s\n" "CPU usage" "$LOAD1, $LOAD5, $LOAD15 (1, 5, 15 min)"
      printf "$BOLD  * %-20s$ENDCOLOR %s\n" "Memory" "$MEMORY"
      printf "$BOLD  * %-20s$ENDCOLOR %s\n" "System uptime" "$upDays days $upHours hours $upMins minutes $upSecs seconds"
      printf "\n"
      for mnt in data media; do
        dfout=$(df -BG --output=used,size /mnt/$mnt | tail -1)
        used=$(echo $dfout | awk '{print $1}' | tr -d 'G')
        total=$(echo $dfout | awk '{print $2}' | tr -d 'G')
        echo "$mnt     Used $(bc <<< "scale=2; $used/$total*100")% out of " "$total" "GB"
      done
      printf "\n"
      printf "$BOLDService status$ENDCOLOR\n"

      ${pkgs.check-services}/bin/check-services jellyfin.service sonarr.service radarr.service prowlarr.service transmission.service
    '';
  cfg = config.tht.motd;
in {
  options.tht.motd = {
    enable = lib.mkEnableOption "MOTD";
    networkInterfaces = lib.mkOption {
      description = "Network interfaces to monitor";
      type = lib.types.listOf lib.types.str;
      # default = lib.mapAttrsToList (_: val: val.interface)
      default = [];
    };
  };
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      motd
      pkgs.lolcat
      pkgs.figlet
      pkgs.bc
    ];
    programs.zsh.interactiveShellInit = ''
      motd
    '';
  };
}
