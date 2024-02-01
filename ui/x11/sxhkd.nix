{ pkgs, ... }:
let
  appmenu = "rofi -show drun";
  terminal = "kitty";
in {
  services.sxhkd = {
    enable = true;

    keybindings = {
      "alt + shift + {e,d}" = "{~/.config/bspwm/bspwmrc,pkill -USR1 -x sxhkd}";

      "alt + shift + q" = "bspc node -c";

      "{_,shift + }@Print" = "{flameshot gui,peek}";

      "alt + Return" = "${terminal}";
      "@Super_L" = "${appmenu}";

      "alt + {_,shift +}{h,j,k,l}" =
        "bspc node --{focus,swap} {west,south,north,east}";
      "alt + {_,shift +}{1-5}" = "bspc {desktop -f,node -d} {1-5}";
      "alt + f" = "bspc node -t ~fullscreen";
      "alt + d" = "bspc node -t ~floating";
      "alt + r" = "bspc node @parent -R 90";
      "alt + equal" =
        "gap=$(bspc query --tree --monitor | ${pkgs.jq} '.windowGap'); new_gap=$(( $gap + 5 )); bspc config window_gap \${new_gap}";
      "alt + minus" =
        "gap=$(bspc query --tree --monitor | ${pkgs.jq} '.windowGap'); new_gap=$(( $gap - 5 )); bspc config window_gap \${new_gap}";

      "XF86AudioRaiseVolume" = "wpctl set-volume @DEFAULT_SINK@ 0.05+";
      "XF86AudioLowerVolume" = "wpctl set-volume @DEFAULT_SINK@ 0.05-";
      "XF86AudioMute" = "wpctl set-mute @DEFAULT_SINK@ toggle";
      "XF86AudioMicMute" = "wpctl set-mute @DEFAULT_SOURCE@ toggle";
      "XF86AudioPlay" = "playerctl play-pause";
      "XF86AudioNext" = "playerctl next";
      "XF86AudioPrev" = "playerctl previous";
    };
  };
}
