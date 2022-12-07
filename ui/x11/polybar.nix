{ self, pkgs, config, ... }:

{
  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      i3Support = true;
      pulseSupport = true;
    };

    config = rec {
      "fonts" = {
        hack = "Hack Nerd Font:size=12;2";
      };

      "colors" = {
        transparent = "#00000000";
        dark-gray = "#aaa";
        pink = "#df588e";
        purple = "#312a59";
        dark-purple = "#282643";
        slate = "#141321";
        dark = "#111";
        light = "#eee";
      };

      "bar/root" = {
        width = "100%";
        height = "30px";
        offset-y = "1%";
        background = "\${colors.transparent}";
        monitor = "\${env:MONITOR:DP-2}";
        tray-position = "none";
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

        offset-x = "0.5%";
        width = "6%";
        height = "30px";
        radius = 10;

        line-size = "3pt";

        border-size = 1;
        border-color = "\${colors.pink}";


        background = "\${colors.slate}";
        foreground = "\${colors.light}";

        font-0 = "\${fonts.hack}";

        tray-position = "none";
        wm-restack = "i3";

        separator = "";
        module-margin = 1;
        modules-left = "workspaces";
      };

      "bar/top-right" = {
        "inherit" = "bar/root";
        bottom = false;

        offset-x = "78.5%";
        width = "21%";
        height = "30px";
        radius = 10;

        line-size = "3pt";

        border-size = 1;
        border-color = "\${colors.pink}";

        monitor = "\${env:MONITOR:DP-2}";

        background = "\${colors.slate}";
        foreground = "\${colors.light}";

        padding-left = 1;

        font-0 = "\${fonts.hack}";
        tray-position = "none";

        separator = "";
        module-margin = 1;
        modules-left = "volume";
        modules-right = "wireless date";
      };

      "module/workspaces" = {
        type = "internal/i3";
        pin-workspaces = true;
        strip-wsnumbers = true;
        index-sort = true;

        format = "<label-state> <label-mode>";

        #label-dimmed-underline = "\${colors.dark}";

        label-mode = "%mode%";
        #label-mode-background = "${colors.dark-purple}";
        #label-mode-underline = "${colors.fav-purple}";
        label-mode-padding = 1;
        label-mode-font = 3;

        label-focused = "%index%";
        label-focused-background = "\${colors.pink}";
        label-focused-padding = 1;
        label-focused-font = 3;

        label-unfocused = "%index%";
        label-unfocused-background = "\${colors.dark-purple}";
        label-unfocused-foreground = "\${colors.dark-gray}";
        label-unfocused-padding = 1;
        label-unfocused-font = 3;

        label-visible = "%index%";
        #label-visible-background = "${colors.dark-purple}";
        #label-visible-underline = "${colors.light-purple}";
        label-visible-padding = 1;
        label-visible-font = 3;

        label-urgent = "%index%";
        #label-urgent-background = "${colors.dark-red}";
        #label-urgent-underline = "${colors.light-red}";
        label-urgent-padding = 1;
        label-urgent-font = 3;

      };

      "module/volume" = {
        type = "internal/pulseaudio";
        format-muted = "<label-muted>";
        format-volume = "墳 <label-volume> <bar-volume>";
        label-volume = "%percentage%%";
        label-muted = "%{F#e57373}%{F-} muted";

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
        format-background = "\${colors.dark-purple}";
        date = "%d.%m.%y";
        time = "%H:%M:%S";
        label = " %date% | %time% ";
      };
    };

    script = ''
      #!/usr/bin/env sh
      killall polybar
      polybar root &
      polybar top-left &
      polybar top-right &
    '';
  };
}
