{
  programs.eww.enable = true;
  programs.eww.configDir = ../eww;
  imports = [
    #./i3.nix
    ./sxhkd.nix
    ./bspwm.nix
    ./gtk.nix
    ./polybar.nix
    ./rofi.nix
    ./picom.nix
    # ./betterlockscreen.nix
  ];
}
