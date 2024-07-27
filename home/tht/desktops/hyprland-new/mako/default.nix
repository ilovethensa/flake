{config, ...}: {
  services.mako = {
    enable = true;
    defaultTimeout = 10000;
    extraConfig = ''
      ignore-timeout=1
      anchor=bottom-right
      background-color=#${config.colorScheme.palette.base00}
      text-color=#${config.colorScheme.palette.base05}
      border-color=#${config.colorScheme.palette.base00}
      [urgency=low]
      border-color=#${config.colorScheme.palette.base00}
      [urgency=normal]
      border-color=#${config.colorScheme.palette.base0A}
      [urgency=high]
      border-color=#${config.colorScheme.palette.base08}
    '';
  };
}
