{ self, pkgs, config, ... }:

{
  services.polybar = {
    enable = true;

    config = rec {
      "fonts" = {
        hack = "Hack Nerd Font:size=12;0";
      };

      "colors" = {
        light-red = "#D95B5B";
        light-green = "#249824";
        light-purple = "#A44BA0";
        menucol-yellow = "#F7F272";
        menucol-blue = "#1771F1";
        menucol-orange = "#FFAF60";
        menucol-red = "#F85C50";
        menucol-green = "#77BD8B";
        menucol-sealine = "#00CF91";
        menucol-purple = "#9A76B3";
        menucol-pink = "#FF77BF";
        menucol-deepblue = "#6560FF";
        menucol-lightblue = "#60FFF7";
        fav-purple = "#6633FF";
        dark = "#111";
        dark-red = "#311";
        dark-green = "#131";
        dark-purple = "#201134";
        light = "#eee";
        gray = "#999";
        dark-gray = "#333";
      };

      "bar/top" = {
        enable-ipc = true;
        override-redirect = false;

        bottom = false;

        width = "100%";
        height = "22";
        monitor = "\${env:MONITOR:DP-2}";

        background = "${colors.dark}";
        foreground = "${colors.light}";

        line-color = "${colors.light-purple}";
        line-size = 2;

        separator = "|";

        font-0 = "${fonts.hack}";

        wm-restack = "i3";
        tray-position = "left";

        modules-left = "workspaces";
        modules-right = "wireless-network date";

      };

      "module/workspaces" = {
        type = "internal/i3";
        pin-workspaces = true;
        strip-wsnumbers = true;
        index-sort = true;

        format = "<label-state> <label-mode>";

        label-dimmed-underline = "${colors.dark}";

        label-mode = "%mode%";
        label-mode-background = "${colors.dark-purple}";
        label-mode-underline = "${colors.fav-purple}";
        label-mode-padding = 1;
        label-mode-font = 3;

        label-focused = "%index%";
        label-focused-background = "${colors.dark-green}";
        label-focused-underline = "${colors.light-green}";
        label-focused-padding = 1;
        label-focused-font = 3;

        label-unfocused = "%index%";
        label-unfocused-foreground = "${colors.gray}";
        label-unfocused-padding = 1;
        label-unfocused-font = 3;

        label-visible = "%index%";
        label-visible-background = "${colors.dark-purple}";
        label-visible-underline = "${colors.light-purple}";
        label-visible-padding = 1;
        label-visible-font = 3;

        label-urgent = "%index%";
        label-urgent-background = "${colors.dark-red}";
        label-urgent-underline = "${colors.light-red}";
        label-urgent-padding = 1;
        label-urgent-font = 3;

      };

      "module/date" = {
        type = "internal/date";
        internal = 1;
        date = "%d.%m.%y";
        time = "%H:%M:%S";
        label = "%date% %time%";
      };
    };

    script = ''
      #!/usr/bin/env sh
      killall polybar
      polybar top &
    '';
  };
}
