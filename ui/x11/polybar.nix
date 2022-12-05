{ self, pkgs, config, ... }:

{
  services.polybar = {
    enable = true;

    config = {
      "bar/top" = {
        width = "100%";
        height = "34";
        monitor = "\${env:MONITOR:DP-2}";

        background = "#111111";
        foreground = "#ccffff";

        font-0 = "Hack:size=8";

        modules-left = "i3";
        modules-right = "wireless-network date";

      };

      "module/i3" = {
        type = "internal/i3";
        pin-workspaces = true;
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
