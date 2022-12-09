{ self, pkgs, lib, ... }:

let
  appmenu = "rofi -show run";
  terminal = "kitty";
in
{
  services.sxhkd = {
    enable = true;

    keybindings = {
      "shift + Tab + e" = "${terminal}";

      "@Super_L" = "${appmenu}";

      "alt + {_,shift +}{h,j,k,l}" = "bspc node --{focus,swap} {west,south,north,east}";
      "alt + {_,shift +}{1-5}" = "bspc {desktop -f,node -d} {1-5}";
    };
  };
}
