{ pkgs, ... }:

{
  home.sessionVariables."BROWSER" = "firefox";
  home.packages = with pkgs; [
    borgbackup
    firefox
    gparted
    gvfs
    killall
    lightdm
    lxappearance
    neofetch
    nix-index
    transmission-gtk
    thefuck
    xfce.thunar
    unetbootin
    unzip
    wget
    xdotool
    xorg.xwininfo
  ];
}
