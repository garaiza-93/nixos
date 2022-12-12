{ self, pkgs, config, ... }:

{
  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      pulseSupport = true;
    };

    config = {
      "fonts" = {
        hack = "Hack Nerd Font:size=12;2";
      };

      "colors" = {
        transparent = "#00000000";
        dark-gray = "#aaa";
        pink = "#df588e";
        purple = "#765898";
        dark-purple = "#282643";
        slate = "#141376";
        dark-opaque = "#a0111111";
        light = "#eee";
      };

      "bar/root" = {
        width = "100%";
        height = 40;
        radius = 15;
        offset-y = 25;
        font-0 = "\${fonts.hack}";
        background = "\${colors.transparent}";
        monitor = "\${env:MONITOR:DP-2}";
        tray-position = "none";
        wm-restack = "bspwm";
        override-redirect = true;
        modules-left = "none";
      };

      "module/none" = {
        type = "custom/text";
        content = " ";
      };

      "bar/top-left" = {
        "inherit" = "bar/root";
        enable-ipc = true;
        bottom = false;

        offset-x = 25;
        width = 150;

        background = "\${colors.dark-purple}";
        foreground = "\${colors.light}";

        tray-position = "none";

        modules-left = "workspaces";
        module-padding = 1;
      };

      "bar/top-right" = {
        "inherit" = "bar/root";
        bottom = false;

        offset-x = "1997.4";
        width = 538;

        line-size = "3pt";

        background = "\${colors.dark-purple}";
        foreground = "\${colors.light}";

        padding-left = 1;

        tray-position = "none";

        separator = "";
        module-margin = 1;
        modules-left = "volume";
        modules-right = "wireless date";
      };

      "bar/allinone" = {
        wm-restack = "bspwm";

        width = "100%";
        height = 40;

        background = "\${colors.dark-opaque}";
        foreground = "\${colors.light}";

        border-bottom-size = "2px";
        border-color = "\${colors.purple}";

        font-0 = "\${fonts.hack}";

        tray-position = "center";

        separator = "";
        module-margin = 1;
        modules-left = "workspaces";
        modules-right = "volume wireless date";
      };

      "module/workspaces" = {
        type = "internal/bspwm";
        enable-click = true;

        format = "<label-state> ";

        label-focused = "%name%";
        label-occupied = "%name%";
        label-empty = "%name%";
        label-urgent = "%name%";

        label-focused-padding = 1;
        label-occupied-padding = 1;
        label-empty-padding = 1;
        label-urgent-padding = 1;

        label-focused-foreground = "\${colors.light}";
        label-focused-background = "\${colors.purple}";

        label-empty-foreground = "\${colors.dark-gray}";
      };

      "module/volume" = {
        type = "internal/pulseaudio";
        format-muted = "<label-muted>";
        format-volume = "墳 <label-volume> <bar-volume>";
        label-volume = "%percentage%%";
        label-muted = "%{F#df588e}%{F-} muted";

        bar-volume-width = 8;
        bar-volume-empty = "%{T7}━%{T-}";
        bar-volume-empty-foreground = "\${colors.dark-purple}";
        bar-volume-fill = "%{T7}━%{T-}";
        bar-volume-foreground = "\${colors.light}";
        bar-volume-indicator = "%{T7}━%{T-}";

      };

      "module/wireless" = {
        type = "internal/network";
        interface-type = "wireless";

        speed-unit = "";

        format-connected = "<label-connected>";
        format-disconnected = "<label-disconnected>";

        label-connected = "直  online";
        label-disconnected = "睊  offline";
      };

      "module/date" = {
        type = "internal/date";
        #format-background = "\${colors.dark-purple}";
        date = "%d.%m.%y";
        time = "%H:%M:%S";
        label = " %date% | %time% ";
      };
    };

    script = ''
      #!/usr/bin/env sh
      killall polybar
      polybar allinone &
    '';

    #      polybar root &
    #      polybar top-left &
    #      polybar top-right &
  };
}
