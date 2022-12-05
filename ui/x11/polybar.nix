{ self, pkgs, config, ... }:

{
  services.polybar = {
    enable = true;

    config = {
      "bar/top" = {
        width = "100%";
        height = "34";

        background = "#00000000";
        foreground = "#ccffffff";

        font-0 = "Hack:size-8";

        modules-left = "i3";
        modules-right = "wireless-network date";

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
