{ pkgs, lib, ... }:

{
  xsession.windowManager.i3 = {
    enable = true;
    config = rec {
      modifier = "Mod1";
      menu = "${pkgs.dmenu}/bin/dmenu_run";
      terminal = "${pkgs.kitty}/bin/kitty";
      bars = [
        {
          id = "bar-1";
          position = "top";
          fonts = {
            names = [ "Hack Nerd Font" "FontAwesome" ];
            size = 8.0;
          };
          statusCommand = "i3status";
        }
      ];

      window.border = 0;

      gaps = {
        inner = 5;
        outer = 5;
      };

      keybindings = lib.mkOptionDefault {
        "XF86AudioRaiseVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +10% && $refresh_i3status";
        "XF86AudioLowerVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -10% && $refresh_i3status";
        "XF86AudioMute" = "exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle && $refresh_i3status";
        "XF86AudioMicMute" = "exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle && $refresh_i3status";

        "Super_L" = "exec --no-startup-id ${menu} -i";
        "Print" = "exec flameshot gui";
        "${modifier}+Shift+q" = "kill";
        "${modifier}+Return" = "exec ${terminal}";

        "${modifier}+h" = "focus left";
        "${modifier}+j" = "focus down";
        "${modifier}+k" = "focus up";
        "${modifier}+l" = "focus right";
        "${modifier}+Shift+h" = "move left";
        "${modifier}+Shift+j" = "move down";
        "${modifier}+Shift+k" = "move up";
        "${modifier}+Shift+l" = "move right";

        "${modifier}+z" = "split h";
        "${modifier}+x" = "split v";

      };

      modes = {
        resize = {
          "h" = "resize shrink width 10 px or 10 ppt";
          "j" = "resize grow height 10 px or 10 ppt";
          "k" = "resize shrink height 10 px or 10 ppt";
          "l" = "resize grow width 10 px or 10 ppt";
          "r" = "mode default";
        };
      };

      focus = {
        followMouse = false;
      };

      floating = {
        modifier = "Mod1";
      };
    };

    extraConfig = ''
      set $refresh_i3status killall -SIGUSR1 i3status
      tiling_drag modifier titlebar
    '';
  };
}
