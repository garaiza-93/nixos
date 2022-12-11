{ self, pkgs, lib, ... }:

let
  appmenu = "rofi -show run";
  terminal = "kitty";
in
{
  services.sxhkd = {
    enable = true;

    keybindings = {
      "alt + shift + {e,d}" = "{~/.config/bspwm/bspwmrc,pkill -USR1 -x sxhkd}";

      "alt + shift + q" = "bspc node -c";

      "@Print" = "flameshot gui";

      "alt + Return" = "${terminal}";
      "@Super_L" = "${appmenu}";

      "alt + {_,shift +}{h,j,k,l}" = "bspc node --{focus,swap} {west,south,north,east}";
      "alt + {_,shift +}{1-5}" = "bspc {desktop -f,node -d} {1-5}";
      "alt + f" = "bspc node -t \~fullscreen";
    };
  };
}
