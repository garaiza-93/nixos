{ pkgs, lib, ... }:

{
  xsession.windowManager.i3 = {
    enable = true;

    config = rec {
      modifier = "Mod1";

      menu = "${pkgs.rofi}/bin/rofi";
      terminal = "${pkgs.kitty}/bin/kitty";

      fonts = {
        names = [ "Hack Nerd Font" ];
        size = 8.0;
      };

      window.border = 1;

      gaps = {
        inner = 5;
        outer = 5;
      };

      defaultWorkspace = "$ws1";
      workspaceAutoBackAndForth = true;

      assigns = {
        "$ws1" = [{ class = "^Firefox$"; }];
        "$ws2" = [{ class = "^Steam$"; }];
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

        "${modifier}+1" = "workspace $ws1";
        "${modifier}+2" = "workspace $ws2";
        "${modifier}+3" = "workspace $ws3";
        "${modifier}+4" = "workspace $ws4";
        "${modifier}+5" = "workspace $ws5";
        "${modifier}+6" = "workspace $ws6";
        "${modifier}+7" = "workspace $ws7";
        "${modifier}+8" = "workspace $ws8";
        "${modifier}+9" = "workspace $ws9";
        "${modifier}+0" = "workspace $ws10";

      };

      modes = {
        resize = {
          "h" = "resize grow width 10 px or 10 ppt";
          "j" = "resize shrink height 10 px or 10 ppt";
          "k" = "resize grow height 10 px or 10 ppt";
          "l" = "resize shrink width 10 px or 10 ppt";
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
      set $ws1 "1"
      set $ws2 "2"
      set $ws3 "3"
      set $ws4 "4"
      set $ws5 "5"
      set $ws6 "6"
      set $ws7 "7"
      set $ws8 "8"
      set $ws9 "9"
      set $ws10 "10"
    '';
  };
}
