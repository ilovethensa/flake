{config, ...}: {
  programs.swaylock = {
    enable = true;
    settings = {
      color = "${config.colorScheme.palette.base03}";
      bs-hl-color = "${config.colorScheme.palette.base04}";
      caps-lock-bs-hl-color = "${config.colorScheme.palette.base04}";
      caps-lock-key-hl-color = "${config.colorScheme.palette.base06}";
      inside-color = "00000000";
      inside-clear-color = "00000000";
      inside-caps-lock-color = "00000000";
      inside-ver-color = "00000000";
      inside-wrong-color = "00000000";
      key-hl-color = "${config.colorScheme.palette.base06}";
      layout-bg-color = "00000000";
      layout-border-color = "00000000";
      layout-text-color = "${config.colorScheme.palette.base05}";
      line-color = "00000000";
      line-clear-color = "00000000";
      line-caps-lock-color = "00000000";
      line-ver-color = "00000000";
      line-wrong-color = "00000000";
      ring-color = "${config.colorScheme.palette.base07}";
      ring-clear-color = "${config.colorScheme.palette.base04}";
      ring-caps-lock-color = "${config.colorScheme.palette.base09}";
      ring-ver-color = "${config.colorScheme.palette.base0B}";
      ring-wrong-color = "${config.colorScheme.palette.base08}";
      separator-color = "00000000";
      text-color = "${config.colorScheme.palette.base05}";
      text-clear-color = "${config.colorScheme.palette.base04}";
      text-caps-lock-color = "${config.colorScheme.palette.base09}";
      text-ver-color = "${config.colorScheme.palette.base0B}";
      text-wrong-color = "${config.colorScheme.palette.base08}";
    };
  };
}
